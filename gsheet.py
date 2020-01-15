#!/usr/bin/env python3

import db
import pytz
import pprint
import gspread
#import logging
import datetime
from oauth2client.service_account import ServiceAccountCredentials

scope = ['https://spreadsheets.google.com/feeds','https://www.googleapis.com/auth/drive']
creds = ServiceAccountCredentials.from_json_keyfile_name('env/python_tfbot_sheet.json', scope)
client = gspread.authorize(creds)

def export_google_sheets() -> None:
  """Возвращает все расходы"""
  cursor = db.get_cursor()
  cursor.execute(
      "select e.id, e.amount, c.name, e.raw_text, e.created "
      "from expense e left join category c "
      "on c.codename=e.category_codename "
      "order by created desc")
  rows = cursor.fetchall()
  all_expenses = []
  for row in rows:
    all_expenses.append({
        'amount': row[1],
        'id': row[0],
        'category_name': row[2],
        'raw_text': row[3],
        'created': row[4]
    })

  spreadsheet = client.open('TelegramFinanceBotReport')
  ws = spreadsheet.sheet1
  if ws.title != "All Database": ws.update_title("All Database")
  ws.resize(1, 6)

  spreadsheet.values_update(
    'All Database!A1',
    params={
      'valueInputOption': 'USER_ENTERED'
    },
    body={
      'values': [[
        "##", "Номер строки", "Дата и время", "Сумма", "Категория", "Исходник"
      ]]
    })

  n = 1
  for row in all_expenses:
    ws.append_row([
      f"{n}",
      f"{row['id']}",
      f"{row['created']}",
      f"{row['amount']}",
      f"{row['category_name']}",
      f"{row['raw_text']}"
    ],
    value_input_option='USER_ENTERED')
    n += 1
