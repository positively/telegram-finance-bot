create table budget(
    codename varchar(255) primary key,
    daily_limit integer
);

create table category(
    codename varchar(255) primary key,
    name varchar(255),
    is_base_expense boolean,
    aliases text
);

create table expense(
    id integer primary key,
    amount integer,
    created datetime,
    category_codename integer,
    raw_text text,
    FOREIGN KEY(category_codename) REFERENCES category(codename)
);

insert into category (codename, name, is_base_expense, aliases)
values
    ("products", "продукты", true,
        "еда, хавка, магазин, атб, фора, ашан, новус, novus, сильпо, billa, билла, базар, супермаркет, маркет"),
    ("coffee", "кофе", false,
        "капучино, лате, американо, эспрессо"),
    ("tobacco", "табак", false,
        "сигареты, сиги, табакерка"),
    ("alcohol", "алкоголь", false,
        "пиво, вино, виски, коньяк, водка, ликер"),
    ("medicine", "медицина", true,
        "лекарство, таблетки, аптека, витамины"),
    ("dinner", "обед", true,
        "столовая, ланч, бизнес-ланч, бизнес ланч"),
    ("cafe", "кафе", false,
        "ресторан, рест, мак, макдональдс, макдак, kfc, пицца, пиццерия"),
    ("transport", "общ. транспорт", true,
        "метро, автобус, metro, трамвай, троллейбус, маршрутка, фуникулер"),
    ("taxi", "такси", false,
        "уклон, убер"),
    ("books", "книги", true,
        "литература, литра, лит-ра"),
    ("phone", "телефон", true,
        "тел, моб, мобильный, связь"),
    ("internet", "интернет", true,
        "инет, inet"),
    ("television", "телевизор", true,
        "тв, tv, телевидение"),
    ("subscriptions", "подписки", true,
        "подписка, гугл драйв, гугл диск, google drive, youtube premium, youtube prem, ютуб прем, ютуб премиум"),
    ("other", "прочее", false, "");

insert into budget(codename, daily_limit) values ('base', 350);
