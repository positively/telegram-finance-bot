create table budget(
    codename varchar(255) primary key,
    daily_limit integer
);

CREATE TABLE IF NOT EXISTS "category" (
    "order" INTEGER,
    "codename" varchar(255) primary key,
    "name" varchar(255),
    "is_base_expense" boolean,
    "aliases" text
);

create table expense(
    id integer primary key,
    amount integer,
    created datetime,
    category_codename integer,
    raw_text text,
    FOREIGN KEY(category_codename) REFERENCES category(codename)
);

INSERT INTO "category" ("order","codename","name","is_base_expense","aliases")
VALUES
    (10, "products", "продукты", true,
        "еда, хавка, магазин, атб, фора, ашан, новус, novus, сильпо, billa, билла, базар, супермаркет, маркет"),
    (20, "coffee", "кофе", false,
        "капучино, лате, американо, эспрессо"),
    (30, "tobacco", "табак", false,
        "сигареты, сиги, табакерка"),
    (40, "alcohol", "алкоголь", false,
        "пиво, вино, виски, коньяк, водка, ликер"),
    (50, "medicine", "медицина", true,
        "лекарство, таблетки, аптека, витамины"),
    (60, "dinner", "обед", true,
        "столовая, ланч, бизнес-ланч, бизнес ланч"),
    (70, "cafe", "кафе", false,
        "ресторан, рест, мак, макдональдс, макдак, kfc, пицца, пиццерия"),
    (80, "transport", "общ. транспорт", true,
        "метро, автобус, metro, трамвай, троллейбус, маршрутка, фуникулер"),
    (90, "taxi", "такси", false,
        "уклон, убер"),
    (100, "books", "книги", true,
        "литература, литра, лит-ра"),
    (110, "subscriptions", "подписки", true,
        "подписка, гугл драйв, гугл диск, google drive, youtube premium, youtube prem, ютуб прем, ютуб премиум"),
    (10000, "other", "прочее", false,
        ""),
    (120, "pets", "животные", true,
        "животное, кот, котик, кошка, собака, корм, наполнитель, мышь, хомяк, свинка, птичка"),
    (130, "banks", "банк", true,
        "банки, укрсиббанк, приватбанк, альфабанк, монобанк, ukrsib, privat24, alfabank, кредит"),
    (140, 'utilities', 'комм. платежи', true,
        'коммуналка, инет, inet, тв, tv, телевидение, тел, моб, мобильный, сотовый, консьерж, домофон, телефон'),
    (150, 'rent', 'аренда', true,'
        аренда'),
    (160, 'debt', 'долг', true,
        'долги'),
    (170, 'barbershop', 'парикмахерская',true,
        'барбершоп, стрижка'),
    (180, 'household', 'хоз. товары', true,
        'хозтовары, хозка'),
    (190, 'cosmetics', 'косметика', true,
        'помада, тоналка, пудра, туш'),
    (200, 'clothes', 'одежда', true,
        'шмотки'),
    (210, 'shoes', 'обувь', true,
        'кросы, тапки'),
    (220, 'accessories', 'украшения', false,
        'сережки, кольцо, браслет, кулон, подвеска'),
    (230, 'gifts', 'подарки', false,
        'подарок'),
    (240, 'sport', 'спорт', true,
        'спортзал, бассейн, спортлайф, sportlife'),
    (250, 'education', 'обучение', true,
        'школа, автошкола, английский, инглишь, курсы, универ, тренинг');

insert into budget(codename, daily_limit) values ('base', 350);
