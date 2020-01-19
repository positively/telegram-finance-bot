#!/usr/bin/env python3

import os
import db
import re
import gspread
#import logging
import datetime
from oauth2client.service_account import ServiceAccountCredentials

def export_google_sheets() -> str:
  #logging.warning(f'export google sheets method called.')
  GOOGLE_DRIVE_API_KEYFILE = os.getenv('GOOGLE_DRIVE_API_KEYFILE_NAME')
  if not GOOGLE_DRIVE_API_KEYFILE:
    return (f"Гугл аккаунт не настроен\n"
            f"https://towardsdatascience.com/accessing-google-spreadsheet-data-using-python-90a5bc214fd2")

  scope = ['https://spreadsheets.google.com/feeds','https://www.googleapis.com/auth/drive']
  creds = ServiceAccountCredentials.from_json_keyfile_name('env/' + GOOGLE_DRIVE_API_KEYFILE, scope)
  client = gspread.authorize(creds)

  """Return all expenses"""
  cursor = db.get_cursor()
  cursor.execute(
      "select e.id, e.amount, c.name, e.raw_text, e.created "
      "from expense e left join category c "
      "on c.codename=e.category_codename "
      "order by created desc")
  rows = cursor.fetchall()
  all_expenses = []
  for row in rows:
    raw_text = re.match(r"^([\d]+)\s+(.*?)$", row[3], re.MULTILINE)
    db_datetime = re.match(r"(\d+\.\d+\.\d+)\s(\d+:\d+:\d+)",
      datetime.datetime.strptime(row[4], "%Y-%m-%d %H:%M:%S").strftime("%d.%m.%Y %H:%M:%S"))
    all_expenses.append({
        'amount': row[1],
        'id': row[0],
        'category_name': row[2],
        'raw_text': raw_text.group(2),
        'created_date': db_datetime.group(1),
        'created_time': db_datetime.group(2)
    })

  """Open google spreadsheat"""
  spreadsheet = client.open('TelegramFinanceBotReport')

  """Open 1st worksheet"""
  ws = spreadsheet.sheet1

  """Rename worksheet"""
  if ws.title != "All Database": ws.update_title("All Database")

  """Clean the sheet"""
  ws.resize(100, 12)
  ws.clear()

  """Append header"""
  ws.append_row([
    f"_",
    f"_",
    f"_",
    f"_",
    f"[ Общая сумма ]",
    f"_",
    f"_"
  ],
  value_input_option='RAW')
  ws.append_row([
    f"##",
    f"ID",
    f"Дата",
    f"Время",
    f"Сумма",
    f"Категория",
    f"Исходник"
  ],
  value_input_option='USER_ENTERED')

  """Draw worksheet"""
  n = 1
  for row in all_expenses:
    ws.append_row([
      f"{n}",
      f"{row['id']}",
      f"{row['created_date']}",
      f"{row['created_time']}",
      f"{row['amount']}",
      f"{row['category_name']}",
      f"{row['raw_text']}"
    ],
    value_input_option='USER_ENTERED')
    n += 1

  """Update SUM in header"""
  ws.update_acell('E1', '=SUM(E3:E)')

  return (f"Экспортировал")
