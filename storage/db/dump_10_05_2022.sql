-- Adminer 4.8.1 MySQL 5.7.37-0ubuntu0.18.04.1 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `ax_address`;
CREATE TABLE `ax_address`
(
    `id`          bigint(20) unsigned  NOT NULL AUTO_INCREMENT,
    `resource`    varchar(255)         NOT NULL,
    `resource_id` bigint(20) unsigned  NOT NULL,
    `type`        smallint(3) unsigned NOT NULL,
    `is_delivery` tinyint(1) unsigned DEFAULT '0',
    `index`       int(11)             DEFAULT NULL,
    `country`     varchar(255)        DEFAULT NULL,
    `region`      varchar(255)        DEFAULT NULL,
    `city`        varchar(255)        DEFAULT NULL,
    `street`      varchar(255)        DEFAULT NULL,
    `house`       varchar(255)        DEFAULT NULL,
    `apartment`   varchar(255)        DEFAULT NULL,
    `description` text,
    `image`       varchar(255)        DEFAULT NULL,
    `created_at`  int(11) unsigned    DEFAULT NULL,
    `updated_at`  int(11) unsigned    DEFAULT NULL,
    `deleted_at`  int(11) unsigned    DEFAULT NULL,
    PRIMARY KEY (`id`, `resource`, `resource_id`),
    UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_catalog_basket`;
CREATE TABLE `ax_catalog_basket`
(
    `id`                  bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `user_id`             bigint(20) unsigned NOT NULL,
    `catalog_product_id`  bigint(20) unsigned NOT NULL,
    `catalog_document_id` bigint(20) unsigned DEFAULT NULL,
    `currency_id`         bigint(20) unsigned DEFAULT NULL,
    `ips_id`              bigint(20) unsigned DEFAULT NULL,
    `quantity`            int(11)             DEFAULT NULL,
    `status`              tinyint(1) unsigned DEFAULT '0',
    `created_at`          int(11) unsigned    DEFAULT NULL,
    `updated_at`          int(11) unsigned    DEFAULT NULL,
    `deleted_at`          int(11) unsigned    DEFAULT NULL,
    PRIMARY KEY (`id`, `user_id`, `catalog_product_id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    KEY `fk_ax_catalog_basket_ax_user1_idx` (`user_id`),
    KEY `fk_ax_catalog_basket_ax_ips1_idx` (`ips_id`),
    KEY `fk_ax_catalog_basket_ax_currency1_idx` (`currency_id`),
    KEY `fk_ax_catalog_basket_ax_catalog_document1_idx` (`catalog_document_id`),
    KEY `fk_ax_catalog_basket_ax_catalog_product1_idx` (`catalog_product_id`),
    CONSTRAINT `fk_ax_catalog_basket_ax_catalog_document1` FOREIGN KEY (`catalog_document_id`) REFERENCES `ax_catalog_document` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_basket_ax_catalog_product1` FOREIGN KEY (`catalog_product_id`) REFERENCES `ax_catalog_product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_basket_ax_currency1` FOREIGN KEY (`currency_id`) REFERENCES `ax_currency` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_basket_ax_ips1` FOREIGN KEY (`ips_id`) REFERENCES `ax_ips` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_basket_ax_user1` FOREIGN KEY (`user_id`) REFERENCES `ax_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO `ax_catalog_basket` (`id`, `user_id`, `catalog_product_id`, `catalog_document_id`, `currency_id`, `ips_id`,
                                 `quantity`, `status`, `created_at`, `updated_at`, `deleted_at`)
VALUES (1, 6, 4, NULL, NULL, 1, 1, 0, 1652124555, 1652124555, NULL);

DROP TABLE IF EXISTS `ax_catalog_category`;
CREATE TABLE `ax_catalog_category`
(
    `id`                  bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `category_id`         bigint(20) unsigned DEFAULT NULL,
    `render_id`           bigint(20) unsigned DEFAULT NULL,
    `is_published`        tinyint(1) unsigned DEFAULT '1',
    `is_favourites`       tinyint(1) unsigned DEFAULT '0',
    `is_watermark`        tinyint(1)          DEFAULT '1',
    `image`               varchar(255)        DEFAULT NULL,
    `show_image`          tinyint(1)          DEFAULT '1',
    `url`                 varchar(500)        NOT NULL,
    `alias`               varchar(255)        NOT NULL,
    `title`               varchar(255)        NOT NULL,
    `title_short`         varchar(150)        DEFAULT NULL,
    `description`         text,
    `preview_description` text,
    `title_seo`           varchar(255)        DEFAULT NULL,
    `description_seo`     varchar(255)        DEFAULT NULL,
    `sort`                int(11) unsigned    DEFAULT '0',
    `created_at`          int(11) unsigned    DEFAULT NULL,
    `updated_at`          int(11) unsigned    DEFAULT NULL,
    `deleted_at`          int(11) unsigned    DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    UNIQUE KEY `url_UNIQUE` (`url`),
    UNIQUE KEY `alias_UNIQUE` (`alias`),
    KEY `fk_ax_catalog_category_ax_catalog_category1_idx` (`category_id`),
    KEY `fk_ax_catalog_category_ax_render1_idx` (`render_id`),
    CONSTRAINT `fk_ax_catalog_category_ax_catalog_category1` FOREIGN KEY (`category_id`) REFERENCES `ax_catalog_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_category_ax_render1` FOREIGN KEY (`render_id`) REFERENCES `ax_render` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO `ax_catalog_category` (`id`, `category_id`, `render_id`, `is_published`, `is_favourites`, `is_watermark`,
                                   `image`, `show_image`, `url`, `alias`, `title`, `title_short`, `description`,
                                   `preview_description`, `title_seo`, `description_seo`, `sort`, `created_at`,
                                   `updated_at`, `deleted_at`)
VALUES (2, NULL, NULL, 0, 0, 0, NULL, 0, 'razdelochnye-servirovochnye-doski', 'razdelochnye-servirovochnye-doski',
        'Разделочные | Сервировочные доски', NULL, NULL, NULL, NULL, NULL, NULL, 1651611600, 1651653211, NULL),
       (3, NULL, NULL, 0, 0, 0, NULL, 0, 'doska-kamen', 'doska-kamen', 'доска \"Камень\"', NULL, NULL, NULL, NULL, NULL,
        NULL, 1651611600, 1651653234, NULL),
       (4, NULL, NULL, 0, 0, 0, NULL, 0, 'torcevye-doski', 'torcevye-doski', 'Торцевые доски', NULL, NULL, NULL, NULL,
        NULL, NULL, 1651611600, 1651653255, NULL),
       (5, NULL, NULL, 0, 0, 0, NULL, 0, 'podnosy', 'podnosy', 'Подносы', NULL, NULL, NULL, NULL, NULL, NULL,
        1651611600, 1651653276, NULL),
       (6, NULL, NULL, 0, 0, 0, NULL, 0, 'podstavka-dlya-telefona', 'podstavka-dlya-telefona', 'Подставка для телефона',
        NULL, NULL, NULL, NULL, NULL, NULL, 1651611600, 1651653306, NULL),
       (7, NULL, NULL, 0, 0, 0, NULL, 0, 'soputstvuyushie-tovary', 'soputstvuyushie-tovary', 'Сопутствующие товары',
        NULL, NULL, NULL, NULL, NULL, NULL, 1651611600, 1651653413, NULL);

DROP TABLE IF EXISTS `ax_catalog_category_has_property`;
CREATE TABLE `ax_catalog_category_has_property`
(
    `catalog_category_id` bigint(20) unsigned NOT NULL,
    `catalog_property_id` bigint(20) unsigned NOT NULL,
    PRIMARY KEY (`catalog_category_id`, `catalog_property_id`),
    KEY `fk_ax_catalog_category_has_ax_catalog_property_ax_catalog_p_idx` (`catalog_property_id`),
    KEY `fk_ax_catalog_category_has_ax_catalog_property_ax_catalog_c_idx` (`catalog_category_id`),
    CONSTRAINT `fk_ax_catalog_category_has_ax_catalog_property_ax_catalog_cat1` FOREIGN KEY (`catalog_category_id`) REFERENCES `ax_catalog_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_category_has_ax_catalog_property_ax_catalog_pro1` FOREIGN KEY (`catalog_property_id`) REFERENCES `ax_catalog_property` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_catalog_coupon`;
CREATE TABLE `ax_catalog_coupon`
(
    `id`          bigint(20) unsigned  NOT NULL AUTO_INCREMENT,
    `resource`    varchar(255)                  DEFAULT NULL,
    `resource_id` bigint(20) unsigned           DEFAULT NULL,
    `value`       varchar(255)         NOT NULL,
    `discount`    smallint(3) unsigned NOT NULL DEFAULT '10',
    `state`       smallint(2) unsigned          DEFAULT '0',
    `image`       varchar(255)                  DEFAULT NULL,
    `expired_at`  int(11) unsigned              DEFAULT NULL,
    `created_at`  int(11) unsigned              DEFAULT NULL,
    `updated_at`  int(11) unsigned              DEFAULT NULL,
    `deleted_at`  int(11) unsigned              DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    UNIQUE KEY `value_UNIQUE` (`value`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_catalog_delivery_type`;
CREATE TABLE `ax_catalog_delivery_type`
(
    `id`          bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `is_active`   tinyint(1)          NOT NULL DEFAULT '0',
    `title`       varchar(255)        NOT NULL,
    `alias`       varchar(255)        NOT NULL,
    `description` text,
    `image`       varchar(255)                 DEFAULT NULL,
    `sort`        tinyint(3) unsigned          DEFAULT '100',
    `created_at`  int(11) unsigned             DEFAULT NULL,
    `updated_at`  int(11) unsigned             DEFAULT NULL,
    `deleted_at`  int(11) unsigned             DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO `ax_catalog_delivery_type` (`id`, `is_active`, `title`, `alias`, `description`, `image`, `sort`,
                                        `created_at`, `updated_at`, `deleted_at`)
VALUES (1, 1, 'Служба доставки СДЭК', 'sluzhba-dostavki-sdek', NULL, NULL, 100, 1651608269, 1651608269, NULL),
       (2, 1, 'Курьером по городу', 'kurerom-po-gorodu', NULL, NULL, 100, 1651608269, 1651608269, NULL),
       (3, 1, 'Почта Россия', 'pochta-rossiya', NULL, NULL, 100, 1651608269, 1651608269, NULL);

DROP TABLE IF EXISTS `ax_catalog_document`;
CREATE TABLE `ax_catalog_document`
(
    `id`                          bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `user_id`                     bigint(20) unsigned NOT NULL,
    `catalog_document_subject_id` bigint(20) unsigned NOT NULL,
    `currency_id`                 bigint(20) unsigned DEFAULT NULL,
    `ips_id`                      bigint(20) unsigned DEFAULT NULL,
    `catalog_delivery_type_id`    bigint(20) unsigned DEFAULT NULL,
    `catalog_payment_type_id`     bigint(20) unsigned DEFAULT NULL,
    `status`                      tinyint(1) unsigned DEFAULT '0',
    `created_at`                  int(11) unsigned    DEFAULT NULL,
    `updated_at`                  int(11) unsigned    DEFAULT NULL,
    `deleted_at`                  int(11) unsigned    DEFAULT NULL,
    PRIMARY KEY (`id`, `user_id`, `catalog_document_subject_id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    KEY `fk_ax_catalog_document_ax_user1_idx` (`user_id`),
    KEY `fk_ax_catalog_document_ax_currency1_idx` (`currency_id`),
    KEY `fk_ax_catalog_document_ax_catalog_document_subject1_idx` (`catalog_document_subject_id`),
    KEY `fk_ax_catalog_document_ax_ips1_idx` (`ips_id`),
    KEY `fk_ax_catalog_document_ax_catalog_delivery_type1_idx` (`catalog_delivery_type_id`),
    KEY `fk_ax_catalog_document_ax_catalog_payment_type1_idx` (`catalog_payment_type_id`),
    CONSTRAINT `fk_ax_catalog_document_ax_catalog_delivery_type1` FOREIGN KEY (`catalog_delivery_type_id`) REFERENCES `ax_catalog_delivery_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_document_ax_catalog_document_subject1` FOREIGN KEY (`catalog_document_subject_id`) REFERENCES `ax_catalog_document_subject` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_document_ax_catalog_payment_type1` FOREIGN KEY (`catalog_payment_type_id`) REFERENCES `ax_catalog_payment_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_document_ax_currency1` FOREIGN KEY (`currency_id`) REFERENCES `ax_currency` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_document_ax_ips1` FOREIGN KEY (`ips_id`) REFERENCES `ax_ips` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_document_ax_user1` FOREIGN KEY (`user_id`) REFERENCES `ax_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO `ax_catalog_document` (`id`, `user_id`, `catalog_document_subject_id`, `currency_id`, `ips_id`,
                                   `catalog_delivery_type_id`, `catalog_payment_type_id`, `status`, `created_at`,
                                   `updated_at`, `deleted_at`)
VALUES (1, 6, 3, NULL, 1, NULL, NULL, 1, 1652123811, 1652123811, NULL),
       (2, 6, 3, NULL, 1, NULL, NULL, 1, 1652124172, 1652124172, NULL),
       (3, 6, 3, NULL, 1, NULL, NULL, 1, 1652124216, 1652124216, NULL),
       (4, 6, 3, NULL, 1, NULL, NULL, 1, 1652124229, 1652124229, NULL),
       (5, 6, 3, NULL, 1, NULL, NULL, 1, 1652124259, 1652124259, NULL),
       (6, 6, 3, NULL, 1, NULL, NULL, 1, 1652124282, 1652124282, NULL),
       (7, 6, 3, NULL, 1, NULL, NULL, 1, 1652124309, 1652124309, NULL),
       (8, 6, 3, NULL, 1, NULL, NULL, 1, 1652124321, 1652124321, NULL),
       (9, 6, 3, NULL, 1, NULL, NULL, 1, 1652124334, 1652124334, NULL),
       (10, 6, 3, NULL, 1, NULL, NULL, 1, 1652124450, 1652124450, NULL),
       (11, 6, 3, NULL, 1, NULL, NULL, 1, 1652124463, 1652124463, NULL);

DROP TABLE IF EXISTS `ax_catalog_document_content`;
CREATE TABLE `ax_catalog_document_content`
(
    `id`                  bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `catalog_document_id` bigint(20) unsigned NOT NULL,
    `catalog_product_id`  bigint(20) unsigned NOT NULL,
    `catalog_storage_id`  bigint(20) unsigned NOT NULL,
    `description`         varchar(255)     DEFAULT NULL,
    `created_at`          int(11) unsigned DEFAULT NULL,
    `updated_at`          int(11) unsigned DEFAULT NULL,
    `deleted_at`          int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`, `catalog_document_id`, `catalog_product_id`, `catalog_storage_id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    KEY `fk_ax_document_content_ax_catalog_document1_idx` (`catalog_document_id`),
    KEY `fk_ax_document_content_ax_catalog_product1_idx` (`catalog_product_id`),
    KEY `fk_ax_catalog_document_content_ax_catalog_storage1_idx` (`catalog_storage_id`),
    CONSTRAINT `fk_ax_catalog_document_content_ax_catalog_storage1` FOREIGN KEY (`catalog_storage_id`) REFERENCES `ax_catalog_storage` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_document_content_ax_catalog_document1` FOREIGN KEY (`catalog_document_id`) REFERENCES `ax_catalog_document` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_document_content_ax_catalog_product1` FOREIGN KEY (`catalog_product_id`) REFERENCES `ax_catalog_product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO `ax_catalog_document_content` (`id`, `catalog_document_id`, `catalog_product_id`, `catalog_storage_id`,
                                           `description`, `created_at`, `updated_at`, `deleted_at`)
VALUES (1, 1, 2, 1, NULL, 1652123811, 1652123811, NULL),
       (2, 2, 7, 2, NULL, 1652124172, 1652124172, NULL),
       (3, 3, 10, 3, NULL, 1652124216, 1652124216, NULL),
       (4, 4, 9, 4, NULL, 1652124229, 1652124229, NULL),
       (5, 5, 8, 5, NULL, 1652124259, 1652124259, NULL),
       (6, 6, 6, 6, NULL, 1652124282, 1652124282, NULL),
       (7, 7, 11, 7, NULL, 1652124309, 1652124309, NULL),
       (8, 8, 4, 8, NULL, 1652124321, 1652124321, NULL),
       (9, 9, 5, 9, NULL, 1652124334, 1652124334, NULL),
       (10, 10, 12, 10, NULL, 1652124450, 1652124450, NULL),
       (11, 11, 3, 11, NULL, 1652124463, 1652124463, NULL);

DROP TABLE IF EXISTS `ax_catalog_document_subject`;
CREATE TABLE `ax_catalog_document_subject`
(
    `id`                      bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `fin_transaction_type_id` bigint(20) unsigned NOT NULL,
    `name`                    varchar(45)         NOT NULL,
    `title`                   varchar(500)        NOT NULL,
    `created_at`              int(11) unsigned DEFAULT NULL,
    `updated_at`              int(11) unsigned DEFAULT NULL,
    `deleted_at`              int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`, `fin_transaction_type_id`),
    UNIQUE KEY `name_UNIQUE` (`name`),
    KEY `fk_ax_catalog_document_subject_ax_fin_transaction_type1_idx` (`fin_transaction_type_id`),
    CONSTRAINT `fk_ax_catalog_document_subject_ax_fin_transaction_type1` FOREIGN KEY (`fin_transaction_type_id`) REFERENCES `ax_fin_transaction_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO `ax_catalog_document_subject` (`id`, `fin_transaction_type_id`, `name`, `title`, `created_at`, `updated_at`,
                                           `deleted_at`)
VALUES (1, 1, 'sale', 'Продажа', 1651608269, 1651608269, NULL),
       (2, 2, 'refund', 'Возврат', 1651608269, 1651608269, NULL),
       (3, 2, 'coming', 'Приход', 1651608269, 1651608269, NULL);

DROP TABLE IF EXISTS `ax_catalog_payment_type`;
CREATE TABLE `ax_catalog_payment_type`
(
    `id`          bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `is_active`   tinyint(1)          NOT NULL DEFAULT '0',
    `title`       varchar(255)        NOT NULL,
    `alias`       varchar(255)        NOT NULL,
    `description` text,
    `image`       varchar(255)                 DEFAULT NULL,
    `sort`        tinyint(3) unsigned          DEFAULT '100',
    `created_at`  int(11) unsigned             DEFAULT NULL,
    `updated_at`  int(11) unsigned             DEFAULT NULL,
    `deleted_at`  int(11) unsigned             DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    UNIQUE KEY `alias_UNIQUE` (`alias`),
    UNIQUE KEY `title_UNIQUE` (`title`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO `ax_catalog_payment_type` (`id`, `is_active`, `title`, `alias`, `description`, `image`, `sort`,
                                       `created_at`, `updated_at`, `deleted_at`)
VALUES (1, 1, 'Банковской картой', 'bankovskoj-kartoj', NULL, NULL, 100, 1651608269, 1651608269, NULL),
       (2, 0, 'Электронными деньгами', 'elektronnymi-dengami', NULL, NULL, 100, 1651608269, 1651608269, NULL),
       (3, 0, 'Переводом через интернет-банк', 'perevodom-cherez-internet-bank', NULL, NULL, 100, 1651608269,
        1651608269, NULL);

DROP TABLE IF EXISTS `ax_catalog_product`;
CREATE TABLE `ax_catalog_product`
(
    `id`                  bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `category_id`         bigint(20) unsigned          DEFAULT NULL,
    `render_id`           bigint(20) unsigned          DEFAULT NULL,
    `is_published`        tinyint(1) unsigned NOT NULL DEFAULT '0',
    `is_favourites`       tinyint(1) unsigned          DEFAULT '0',
    `is_comments`         tinyint(1) unsigned          DEFAULT '0',
    `is_watermark`        tinyint(1) unsigned          DEFAULT '1',
    `media`               varchar(255)                 DEFAULT NULL,
    `url`                 varchar(500)        NOT NULL,
    `alias`               varchar(255)        NOT NULL,
    `title`               varchar(255)        NOT NULL,
    `price`               decimal(10, 2)               DEFAULT '0.00',
    `title_short`         varchar(155)                 DEFAULT NULL,
    `preview_description` text,
    `description`         text,
    `title_seo`           varchar(255)                 DEFAULT NULL,
    `description_seo`     varchar(255)                 DEFAULT NULL,
    `show_date`           tinyint(1)                   DEFAULT '1',
    `image`               varchar(255)                 DEFAULT NULL,
    `hits`                int(11) unsigned             DEFAULT '0',
    `sort`                int(11)                      DEFAULT '0',
    `stars`               decimal(10, 2) unsigned      DEFAULT '0.00',
    `created_at`          int(11) unsigned             DEFAULT NULL,
    `updated_at`          int(11) unsigned             DEFAULT NULL,
    `deleted_at`          int(11) unsigned             DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `url_UNIQUE` (`url`),
    UNIQUE KEY `alias_UNIQUE` (`alias`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    KEY `fk_ax_catalog_product_ax_render1_idx` (`render_id`),
    KEY `fk_ax_catalog_product_ax_catalog_category1_idx` (`category_id`),
    CONSTRAINT `fk_ax_catalog_product_ax_catalog_category1` FOREIGN KEY (`category_id`) REFERENCES `ax_catalog_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_product_ax_render1` FOREIGN KEY (`render_id`) REFERENCES `ax_render` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO `ax_catalog_product` (`id`, `category_id`, `render_id`, `is_published`, `is_favourites`, `is_comments`,
                                  `is_watermark`, `media`, `url`, `alias`, `title`, `price`, `title_short`,
                                  `preview_description`, `description`, `title_seo`, `description_seo`, `show_date`,
                                  `image`, `hits`, `sort`, `stars`, `created_at`, `updated_at`, `deleted_at`)
VALUES (2, 3, NULL, 1, 0, 0, 0, NULL, 'zakat', 'zakat', '✶ Закат ✶', 2000.00, NULL, NULL,
        '<p class=\"MsoNormal\" style=\"margin-left:-7.1pt\"><span style=\"font-size: 12pt; line-height: 107%; font-family: \" times=\"\" new=\"\" roman\",=\"\" serif;=\"\" background-image:=\"\" initial;=\"\" background-position:=\"\" background-size:=\"\" background-repeat:=\"\" background-attachment:=\"\" background-origin:=\"\" background-clip:=\"\" initial;\"=\"\">На кухне мы ежедневно используем посуду, доски и другие предметы. <o:p></o:p></span></p><p class=\"MsoNormal\" style=\"margin-left:-7.1pt\"><span style=\"font-size: 12pt; line-height: 107%; font-family: \" times=\"\" new=\"\" roman\",=\"\" serif;=\"\" background-image:=\"\" initial;=\"\" background-position:=\"\" background-size:=\"\" background-repeat:=\"\" background-attachment:=\"\" background-origin:=\"\" background-clip:=\"\" initial;\"=\"\">В основном мы готовим на них, еще на досках мы можем подавать любые нарезки, брускетты, фрукты, закуски.<o:p></o:p></span></p><p class=\"MsoNormal\" style=\"margin-left:-7.1pt\"><span style=\"font-size: 12pt; line-height: 107%; font-family: \" times=\"\" new=\"\" roman\",=\"\" serif;=\"\" background-image:=\"\" initial;=\"\" background-position:=\"\" background-size:=\"\" background-repeat:=\"\" background-attachment:=\"\" background-origin:=\"\" background-clip:=\"\" initial;\"=\"\">Эта доска выполнена из прекрасного дерева Абрикос и что бы вы на ней не подали, все будет выглядеть шикарно, как (в уютном ресторане).<o:p></o:p></span></p><p class=\"MsoNormal\" style=\"margin-left:-7.1pt\"><span style=\"font-size: 12pt; line-height: 107%; font-family: \" times=\"\" new=\"\" roman\",=\"\" serif;=\"\" background-image:=\"\" initial;=\"\" background-position:=\"\" background-size:=\"\" background-repeat:=\"\" background-attachment:=\"\" background-origin:=\"\" background-clip:=\"\" initial;\"=\"\">Друзья оценят такую подачу.<o:p></o:p></span></p><p class=\"MsoNormal\" style=\"margin-left:-7.1pt\"><span style=\"font-size: 12pt; line-height: 107%; font-family: \" times=\"\" new=\"\" roman\",=\"\" serif;=\"\" background-image:=\"\" initial;=\"\" background-position:=\"\" background-size:=\"\" background-repeat:=\"\" background-attachment:=\"\" background-origin:=\"\" background-clip:=\"\" initial;\"=\"\">Согласитесь, куда приятнее кушать красиво ведь это задает определенную атмосферу.</span><span style=\"font-size:12.0pt;line-height:107%;font-family:\" times=\"\" new=\"\" roman\",serif\"=\"\"><br> <br> <span style=\"background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\">Создавая такие вещи, с умилением думаю как вы будете радоваться и рассказывать своим друзьям и близким как ее нашли, как в нее влюбились и теперь она ваша, и такая только у вас. <o:p></o:p></span></span></p><p><br></p>',
        NULL, NULL, 1, '/upload/ax_catalog_product/zakat/I4M5AzlzUdEhSJM1zEVRyp0v0mJNPJogSPFIUVvp.jpeg', 0, 1, 0.00,
        1651861683, 1652124493, NULL),
       (3, 2, NULL, 1, 0, 0, 0, NULL, 'rozmarin', 'rozmarin', '✶ Розмарин ✶', 1100.00, NULL, NULL,
        '<p class=\"MsoNormal\" style=\"margin-left:-7.1pt\"><font face=\"Times New Roman, serif\"><span style=\"font-size: 16px;\">У Вас тоже на кухне есть доски разного калибра?</span></font></p><p class=\"MsoNormal\" style=\"margin-left:-7.1pt\"><font face=\"Times New Roman, serif\"><span style=\"font-size: 16px;\">У меня, да.</span></font></p><p class=\"MsoNormal\" style=\"margin-left:-7.1pt\"><font face=\"Times New Roman, serif\"><span style=\"font-size: 16px;\">Иногда чтоб отрезать что-то небольшое, кусочек сыра, зелень нарезать или лимончик к чаю, совсем не хочется брать большую доску.</span></font></p><p class=\"MsoNormal\" style=\"margin-left:-7.1pt\"><font face=\"Times New Roman, serif\"><span style=\"font-size: 16px;\">Для таких целей и есть такие малышки.</span></font></p>',
        NULL, NULL, 1, '/upload/ax_catalog_product/rozmarin/LRdZmXFINVIPEINGeRVN5EH7fdqOSTcoJr1fkakF.jpeg', 0, 3, 0.00,
        1651861623, 1652124493, NULL),
       (4, 2, NULL, 1, 0, 0, 0, NULL, 'kruassan', 'kruassan', '✶ Круассан ✶', 1800.00, NULL, NULL,
        '<h6 style=\"margin-left:-7.1pt\"><font face=\"Times New Roman, serif\"><span style=\"font-size: 12pt; font-family: Play;\">Утро, вы выходите на террасу или балкон, у вас на доске стоит чашечка ароматного кофе и рядом </span><span style=\"font-size: 16px; font-family: Play;\">пристроился</span><span style=\"font-size: 12pt; font-family: Play;\"> </span><span style=\"font-size: 16px; font-family: Play;\">круассан</span><span style=\"font-size: 12pt; font-family: Play;\"> или бутерброд. </span></font></h6><h6 style=\"margin-left:-7.1pt\"><font face=\"Times New Roman, serif\"><span style=\"font-size: 12pt; font-family: Play;\">Отличное начало дня, как встретишь утро так и </span><span style=\"font-size: 16px; font-family: Play;\">проведёшь</span><span style=\"font-size: 12pt; font-family: Play;\"> день.</span></font></h6><p class=\"MsoNormal\" style=\"margin-left:-7.1pt\"><span style=\"font-family: Play;\" times=\"\" new=\"\" roman\",=\"\" serif;=\"\" font-size:=\"\" 12pt;\"=\"\">Такая доска удобна как для нарезки так и для подачи.</span></p>',
        NULL, NULL, 1, '/upload/ax_catalog_product/kruassan/t1jUF8NpGuvCAmXgIJj0fVntf45wCZ8hp3G0BpTz.jpeg', 0, 6, 0.00,
        1651861563, 1652124493, NULL),
       (5, 2, NULL, 1, 0, 0, 0, NULL, 'artishok', 'artishok', '✶ Артишок ✶', 2000.00, NULL, NULL,
        '<p class=\"MsoNormal\" style=\"margin-left:-7.1pt\"><font face=\"Times New Roman, serif\"><span style=\"font-size: 16px;\">Режем все и много.</span></font></p><p class=\"MsoNormal\" style=\"margin-left:-7.1pt\"><font face=\"Times New Roman, serif\"><span style=\"font-size: 16px;\">Один из удобных размеров для работы на кухне.</span></font></p>',
        NULL, NULL, 1, '/upload/ax_catalog_product/artishok/Y1URWayGpmI4z7kR7Q9Jfgahbvy2IwMoTVo48N79.jpeg', 0, 6, 0.00,
        1651861503, 1652124493, NULL),
       (6, 2, NULL, 1, 0, 0, 0, NULL, 'morkov', 'morkov', '✶ Морковь ✶', 2000.00, NULL, NULL,
        '<p class=\"MsoNormal\" style=\"margin-left:-7.1pt\"><font face=\"Times New Roman, serif\"><span style=\"font-size: 16px;\">Все готовим и режем.</span></font></p><p class=\"MsoNormal\" style=\"margin-left:-7.1pt\"><font face=\"Times New Roman, serif\"><span style=\"font-size: 16px;\">А еще и подаем бутерброды.</span></font></p><p class=\"MsoNormal\" style=\"margin-left:-7.1pt\"><font face=\"Times New Roman, serif\"><span style=\"font-size: 16px;\">На одной стороне режем, другую оставляем для красивой подачи.</span></font></p>',
        NULL, NULL, 1, '/upload/ax_catalog_product/morkov/sY4zEEhOmWFgk8cTkoQXQoXBP9oNF4hKpwtIriF5.jpeg', 0, 7, 0.00,
        1651861443, 1652124493, NULL),
       (7, 2, NULL, 1, 0, 0, 0, NULL, 'syr', 'syr', '✶ Сыр ✶', 2200.00, NULL, NULL,
        '<p class=\"MsoNormal\" style=\"margin-left:-7.1pt\"><font face=\"Times New Roman, serif\"><span style=\"font-size: 16px;\">Режем большой сыр, когда места надо много.</span></font></p><p class=\"MsoNormal\" style=\"margin-left:-7.1pt\"><br></p>',
        NULL, NULL, 1, '/upload/ax_catalog_product/syr/HFlK4SUANdyRRFtEa6hVHZQlW32vXqUQzJgGVZJ4.jpeg', 0, 12, 0.00,
        1651861383, 1652124492, NULL),
       (8, 3, NULL, 1, 0, 0, 0, NULL, 'vorobushek', 'vorobushek', '✶ Воробушек ✶', 2500.00, NULL, NULL,
        '<p>Когда хочется необычного на кухне. Например доску нетрадиционного вида.</p><p>Доска создавалась как для нарезки так и для сервировки.</p><p>Мне нравится такая форма доски, доска \"камушек\".</p><p>Поверьте, она удивит ваших гостей.</p>',
        NULL, NULL, 1, '/upload/ax_catalog_product/vorobushek/iz9EGYTYvTpEW0zFY7M1JjbLFD4K4OFqSKmlteRq.jpeg', 0, 8,
        0.00, 1651861323, 1652124492, NULL),
       (9, 2, NULL, 1, 0, 0, 0, NULL, 'forel', 'forel', '✶ Форель ✶', 2800.00, NULL, NULL,
        '<p>Вы тоже используете для каждых продуктов свою доску?</p><p>Говорят что так правильно и удобно.</p>', NULL,
        NULL, 1, '/upload/ax_catalog_product/forel/M0CR8f6T8xlLuBJpz7eyco5JTVoR6cawebs3ZmOJ.jpeg', 0, 9, 0.00,
        1651861263, 1652124492, NULL),
       (10, 2, NULL, 1, 0, 0, 0, NULL, 'shtopor', 'shtopor', '✶ Штопор ✶', 2300.00, NULL, NULL,
        '<p>Идеальный намёк на чудный вечер.</p>', NULL, NULL, 1,
        '/upload/ax_catalog_product/shtopor/3kjaLFGThRo7azz2oSutNqUlatUnvlr2elROpTUa.jpeg', 0, 11, 0.00, 1651861203,
        1652124492, NULL),
       (11, 2, NULL, 1, 0, 0, 0, NULL, 'paporotnik', 'paporotnik', '✶ Папоротник ✶', 1500.00, NULL, NULL,
        'Готовим вкусно, подаём красиво.', NULL, NULL, 1,
        '/upload/ax_catalog_product/paporotnik/DJiOIvhybxRTee79lp5j914jUfb2ai4dMCXNFXAy.jpeg', 0, 2, 0.00, 1651861143,
        1652124492, NULL),
       (12, 3, NULL, 1, 0, 0, 0, NULL, 'glaz-zebry', 'glaz-zebry', '✶ Глаз зебры ✶', 1600.00, NULL, NULL,
        '<p>Интересная получилась доска.</p><p>Годовые кольца затушевала пирографом, подчеркнула природную красоту. </p><p>Идеальна для подачи. </p><p>Помним, что другую сторону используем для нарезки.</p>',
        NULL, NULL, 1, '/upload/ax_catalog_product/glaz-zebry/MII1UI6mHTDd1oEoS827cFoJF8KSd7X0u0DXLaV7.jpeg', 0, 5,
        0.00, 1651861083, 1652124492, NULL);

DROP TABLE IF EXISTS `ax_catalog_product_has_currency`;
CREATE TABLE `ax_catalog_product_has_currency`
(
    `catalog_product_id` bigint(20) unsigned     NOT NULL,
    `currency_id`        bigint(20) unsigned     NOT NULL,
    `amount`             decimal(10, 2) unsigned NOT NULL DEFAULT '0.00',
    `date_rate`          int(11) unsigned        NOT NULL,
    PRIMARY KEY (`catalog_product_id`, `currency_id`),
    KEY `fk_ax_catalog_product_has_ax_currency_ax_currency1_idx` (`currency_id`),
    KEY `fk_ax_catalog_product_has_ax_currency_ax_catalog_product1_idx` (`catalog_product_id`),
    CONSTRAINT `fk_ax_catalog_product_has_ax_currency_ax_catalog_product1` FOREIGN KEY (`catalog_product_id`) REFERENCES `ax_catalog_product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_product_has_ax_currency_ax_currency1` FOREIGN KEY (`currency_id`) REFERENCES `ax_currency` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_catalog_product_has_value_decimal`;
CREATE TABLE `ax_catalog_product_has_value_decimal`
(
    `id`                       bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `catalog_product_id`       bigint(20) unsigned NOT NULL,
    `catalog_property_id`      bigint(20) unsigned NOT NULL,
    `catalog_property_unit_id` bigint(20) unsigned DEFAULT NULL,
    `value`                    decimal(10, 2)      NOT NULL,
    `sort`                     int(11)             DEFAULT '100',
    `created_at`               int(11) unsigned    DEFAULT NULL,
    `updated_at`               int(11) unsigned    DEFAULT NULL,
    `deleted_at`               int(11) unsigned    DEFAULT NULL,
    PRIMARY KEY (`id`, `catalog_product_id`, `catalog_property_id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    KEY `fk_ax_catalog_product_has_value_int_ax_catalog_product1_idx` (`catalog_product_id`),
    KEY `fk_ax_catalog_product_has_value_decimal_ax_catalog_property_idx` (`catalog_property_id`),
    KEY `fk_ax_catalog_product_has_value_decimal_ax_catalog_property_idx1` (`catalog_property_unit_id`),
    CONSTRAINT `fk_ax_catalog_product_has_value_decimal_ax_catalog_property1` FOREIGN KEY (`catalog_property_id`) REFERENCES `ax_catalog_property` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_product_has_value_decimal_ax_catalog_property_u1` FOREIGN KEY (`catalog_property_unit_id`) REFERENCES `ax_catalog_property_unit` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_product_has_value_int_ax_catalog_product1000` FOREIGN KEY (`catalog_product_id`) REFERENCES `ax_catalog_product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO `ax_catalog_product_has_value_decimal` (`id`, `catalog_product_id`, `catalog_property_id`,
                                                    `catalog_property_unit_id`, `value`, `sort`, `created_at`,
                                                    `updated_at`, `deleted_at`)
VALUES (1, 2, 5, 2, 33.00, 2, 1651665295, 1652124088, NULL),
       (2, 2, 4, 2, 18.50, 3, 1651665295, 1652124088, NULL),
       (3, 2, 3, 2, 2.80, 4, 1651665295, 1652124088, NULL),
       (8, 8, 5, 2, 37.00, 2, 1651687835, 1652124259, NULL),
       (9, 8, 4, 2, 17.00, 3, 1651687835, 1652124260, NULL),
       (10, 3, 5, 2, 20.00, 2, 1651693957, 1652124463, NULL),
       (11, 3, 4, 2, 15.00, 3, 1651693957, 1652124463, NULL),
       (12, 4, 5, 2, 30.00, 2, 1651694072, 1652124322, NULL),
       (13, 4, 4, 2, 16.00, 3, 1651694072, 1652124322, NULL),
       (16, 5, 5, 2, 33.00, 2, 1651694389, 1652124334, NULL),
       (17, 5, 4, 2, 18.00, 3, 1651694389, 1652124334, NULL),
       (18, 6, 5, 2, 32.00, 2, 1651694563, 1652124282, NULL),
       (19, 6, 4, 2, 18.00, 3, 1651694563, 1652124282, NULL),
       (20, 7, 5, 2, 32.00, 2, 1651694793, 1652124172, NULL),
       (21, 7, 4, 2, 20.00, 3, 1651694793, 1652124172, NULL),
       (22, 9, 5, 2, 45.00, NULL, 1651696120, 1652124229, NULL),
       (23, 9, 4, 2, 18.00, NULL, 1651696120, 1652124229, NULL),
       (24, 10, 5, 2, 44.00, 2, 1651696887, 1652124216, NULL),
       (25, 10, 4, 2, 16.00, 3, 1651696887, 1652124216, NULL),
       (26, 11, 5, 2, 33.00, 2, 1651697509, 1652124309, NULL),
       (27, 11, 4, 2, 13.00, 3, 1651697509, 1652124309, NULL),
       (28, 12, 5, 2, 34.00, 2, 1651698934, 1652124450, NULL),
       (29, 12, 4, 2, 13.00, 3, 1651698934, 1652124450, NULL);

DROP TABLE IF EXISTS `ax_catalog_product_has_value_int`;
CREATE TABLE `ax_catalog_product_has_value_int`
(
    `id`                       bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `catalog_product_id`       bigint(20) unsigned NOT NULL,
    `catalog_property_id`      bigint(20) unsigned NOT NULL,
    `catalog_property_unit_id` bigint(20) unsigned DEFAULT NULL,
    `value`                    int(11)             NOT NULL,
    `sort`                     int(11)             DEFAULT '100',
    `created_at`               int(11) unsigned    DEFAULT NULL,
    `updated_at`               int(11) unsigned    DEFAULT NULL,
    `deleted_at`               int(11) unsigned    DEFAULT NULL,
    PRIMARY KEY (`id`, `catalog_product_id`, `catalog_property_id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    KEY `fk_ax_catalog_product_has_value_int_ax_catalog_product1_idx` (`catalog_product_id`),
    KEY `fk_ax_catalog_product_has_value_int_ax_catalog_property1_idx` (`catalog_property_id`),
    KEY `fk_ax_catalog_product_has_value_int_ax_catalog_property_uni_idx` (`catalog_property_unit_id`),
    CONSTRAINT `fk_ax_catalog_product_has_value_int_ax_catalog_product1` FOREIGN KEY (`catalog_product_id`) REFERENCES `ax_catalog_product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_product_has_value_int_ax_catalog_property1` FOREIGN KEY (`catalog_property_id`) REFERENCES `ax_catalog_property` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_product_has_value_int_ax_catalog_property_unit1` FOREIGN KEY (`catalog_property_unit_id`) REFERENCES `ax_catalog_property_unit` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_catalog_product_has_value_text`;
CREATE TABLE `ax_catalog_product_has_value_text`
(
    `id`                       bigint(20) unsigned NOT NULL,
    `catalog_product_id`       bigint(20) unsigned NOT NULL,
    `catalog_property_id`      bigint(20) unsigned NOT NULL,
    `catalog_property_unit_id` bigint(20) unsigned DEFAULT NULL,
    `value`                    text                NOT NULL,
    `sort`                     int(11)             DEFAULT '100',
    `created_at`               int(11) unsigned    DEFAULT NULL,
    `updated_at`               int(11) unsigned    DEFAULT NULL,
    `deleted_at`               int(11) unsigned    DEFAULT NULL,
    PRIMARY KEY (`id`, `catalog_product_id`, `catalog_property_id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    KEY `fk_ax_catalog_product_has_value_int_ax_catalog_product1_idx` (`catalog_product_id`),
    KEY `fk_ax_catalog_product_has_value_text_ax_catalog_property1_idx` (`catalog_property_id`),
    KEY `fk_ax_catalog_product_has_value_text_ax_catalog_property_un_idx` (`catalog_property_unit_id`),
    CONSTRAINT `fk_ax_catalog_product_has_value_int_ax_catalog_product100` FOREIGN KEY (`catalog_product_id`) REFERENCES `ax_catalog_product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_product_has_value_text_ax_catalog_property1` FOREIGN KEY (`catalog_property_id`) REFERENCES `ax_catalog_property` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_product_has_value_text_ax_catalog_property_unit1` FOREIGN KEY (`catalog_property_unit_id`) REFERENCES `ax_catalog_property_unit` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_catalog_product_has_value_varchar`;
CREATE TABLE `ax_catalog_product_has_value_varchar`
(
    `id`                       bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `catalog_product_id`       bigint(20) unsigned NOT NULL,
    `catalog_property_id`      bigint(20) unsigned NOT NULL,
    `catalog_property_unit_id` bigint(20) unsigned DEFAULT NULL,
    `value`                    varchar(500)        NOT NULL,
    `sort`                     int(11)             DEFAULT '100',
    `created_at`               int(11) unsigned    DEFAULT NULL,
    `updated_at`               int(11) unsigned    DEFAULT NULL,
    `deleted_at`               int(11) unsigned    DEFAULT NULL,
    PRIMARY KEY (`id`, `catalog_product_id`, `catalog_property_id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    KEY `fk_ax_catalog_product_has_value_int_ax_catalog_product1_idx` (`catalog_product_id`),
    KEY `fk_ax_catalog_product_has_value_varchar_ax_catalog_property_idx` (`catalog_property_id`),
    KEY `fk_ax_catalog_product_has_value_varchar_ax_catalog_property_idx1` (`catalog_property_unit_id`),
    CONSTRAINT `fk_ax_catalog_product_has_value_int_ax_catalog_product10` FOREIGN KEY (`catalog_product_id`) REFERENCES `ax_catalog_product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_product_has_value_varchar_ax_catalog_property1` FOREIGN KEY (`catalog_property_id`) REFERENCES `ax_catalog_property` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_product_has_value_varchar_ax_catalog_property_u1` FOREIGN KEY (`catalog_property_unit_id`) REFERENCES `ax_catalog_property_unit` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO `ax_catalog_product_has_value_varchar` (`id`, `catalog_product_id`, `catalog_property_id`,
                                                    `catalog_property_unit_id`, `value`, `sort`, `created_at`,
                                                    `updated_at`, `deleted_at`)
VALUES (2, 2, 1, NULL, 'Абрикос', 1, 1651660444, 1652124088, NULL),
       (3, 3, 1, NULL, 'Дуб', 1, 1651686459, 1652124463, NULL),
       (4, 4, 1, 13, 'Дуб', 1, 1651686895, 1652124322, NULL),
       (8, 8, 1, NULL, 'Ясень', 1, 1651687835, 1652124259, NULL),
       (9, 5, 1, NULL, 'Дуб', 1, 1651694263, 1652124334, NULL),
       (10, 6, 1, NULL, 'Дуб', 1, 1651694563, 1652124282, NULL),
       (11, 7, 1, NULL, 'Дуб', 1, 1651694793, 1652124172, NULL),
       (12, 9, 1, NULL, 'Дуб', 1, 1651696120, 1652124229, NULL),
       (13, 10, 1, NULL, 'Дуб', 1, 1651696887, 1652124216, NULL),
       (14, 11, 1, NULL, 'Дуб', 1, 1651697509, 1652124309, NULL),
       (15, 12, 1, NULL, 'Акация', 1, 1651698934, 1652124450, NULL);

DROP TABLE IF EXISTS `ax_catalog_product_widgets`;
CREATE TABLE `ax_catalog_product_widgets`
(
    `id`                 bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `catalog_product_id` bigint(20) unsigned NOT NULL,
    `render_id`          bigint(20) unsigned DEFAULT NULL,
    `name`               varchar(255)        NOT NULL,
    `title`              varchar(255)        NOT NULL,
    `description`        varchar(255)        DEFAULT NULL,
    `created_at`         int(11) unsigned    DEFAULT NULL,
    `updated_at`         int(11) unsigned    DEFAULT NULL,
    `deleted_at`         int(11) unsigned    DEFAULT NULL,
    PRIMARY KEY (`id`, `catalog_product_id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    KEY `fk_ax_catalog_product_widgets_ax_catalog_product1_idx` (`catalog_product_id`),
    KEY `fk_ax_catalog_product_widgets_ax_render1_idx` (`render_id`),
    CONSTRAINT `fk_ax_catalog_product_widgets_ax_catalog_product1` FOREIGN KEY (`catalog_product_id`) REFERENCES `ax_catalog_product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_product_widgets_ax_render1` FOREIGN KEY (`render_id`) REFERENCES `ax_render` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_catalog_product_widgets_content`;
CREATE TABLE `ax_catalog_product_widgets_content`
(
    `id`                         bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `catalog_product_widgets_id` bigint(20) unsigned NOT NULL,
    `title`                      varchar(255)        NOT NULL,
    `title_short`                varchar(155)        NOT NULL,
    `description`                text,
    `image`                      varchar(255)     DEFAULT NULL,
    `sort`                       int(11)          DEFAULT '0',
    `show_image`                 tinyint(1)       DEFAULT '1',
    `media`                      varchar(255)     DEFAULT NULL,
    `created_at`                 int(11) unsigned DEFAULT NULL,
    `updated_at`                 int(11) unsigned DEFAULT NULL,
    `deleted_at`                 int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`, `catalog_product_widgets_id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    UNIQUE KEY `title_UNIQUE` (`title`),
    KEY `fk_ax_catalog_product_widgets_content_ax_catalog_product_wi_idx` (`catalog_product_widgets_id`),
    CONSTRAINT `fk_ax_catalog_product_widgets_content_ax_catalog_product_widg1` FOREIGN KEY (`catalog_product_widgets_id`) REFERENCES `ax_catalog_product_widgets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_catalog_property`;
CREATE TABLE `ax_catalog_property`
(
    `id`                       bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `catalog_property_type_id` bigint(20) unsigned NOT NULL,
    `title`                    varchar(255)        NOT NULL,
    `description`              varchar(255)     DEFAULT NULL,
    `sort`                     int(11)          DEFAULT NULL,
    `image`                    varchar(255)     DEFAULT NULL,
    `created_at`               int(11) unsigned DEFAULT NULL,
    `updated_at`               int(11) unsigned DEFAULT NULL,
    `deleted_at`               int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`, `catalog_property_type_id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    KEY `fk_ax_catalog_property_ax_catalog_property_type1_idx` (`catalog_property_type_id`),
    CONSTRAINT `fk_ax_catalog_property_ax_catalog_property_type1` FOREIGN KEY (`catalog_property_type_id`) REFERENCES `ax_catalog_property_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO `ax_catalog_property` (`id`, `catalog_property_type_id`, `title`, `description`, `sort`, `image`,
                                   `created_at`, `updated_at`, `deleted_at`)
VALUES (1, 1, 'Материал', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (2, 1, 'Цвет', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (3, 4, 'Толщина', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (4, 4, 'Ширина', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (5, 4, 'Длина', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (6, 3, 'Вес', NULL, NULL, NULL, 1651608270, 1651608270, NULL);

DROP TABLE IF EXISTS `ax_catalog_property_group`;
CREATE TABLE `ax_catalog_property_group`
(
    `id`          bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `title`       varchar(255)        NOT NULL,
    `description` varchar(255)     DEFAULT NULL,
    `sort`        int(11)          DEFAULT NULL,
    `image`       varchar(255)     DEFAULT NULL,
    `created_at`  int(11) unsigned DEFAULT NULL,
    `updated_at`  int(11) unsigned DEFAULT NULL,
    `deleted_at`  int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_catalog_property_has_group`;
CREATE TABLE `ax_catalog_property_has_group`
(
    `catalog_property_id`       bigint(20) unsigned NOT NULL,
    `catalog_property_group_id` bigint(20) unsigned NOT NULL,
    PRIMARY KEY (`catalog_property_id`, `catalog_property_group_id`),
    KEY `fk_ax_catalog_property_has_ax_catalog_property_group_ax_cat_idx` (`catalog_property_group_id`),
    KEY `fk_ax_catalog_property_has_ax_catalog_property_group_ax_cat_idx1` (`catalog_property_id`),
    CONSTRAINT `fk_ax_catalog_property_has_ax_catalog_property_group_ax_catal1` FOREIGN KEY (`catalog_property_id`) REFERENCES `ax_catalog_property` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_property_has_ax_catalog_property_group_ax_catal2` FOREIGN KEY (`catalog_property_group_id`) REFERENCES `ax_catalog_property_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_catalog_property_has_unit`;
CREATE TABLE `ax_catalog_property_has_unit`
(
    `catalog_property_id`      bigint(20) unsigned NOT NULL,
    `catalog_property_unit_id` bigint(20) unsigned NOT NULL,
    PRIMARY KEY (`catalog_property_id`, `catalog_property_unit_id`),
    KEY `fk_ax_catalog_property_has_ax_catalog_property_unit_ax_cata_idx` (`catalog_property_unit_id`),
    KEY `fk_ax_catalog_property_has_ax_catalog_property_unit_ax_cata_idx1` (`catalog_property_id`),
    CONSTRAINT `fk_ax_catalog_property_has_ax_catalog_property_unit_ax_catalo1` FOREIGN KEY (`catalog_property_id`) REFERENCES `ax_catalog_property` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_property_has_ax_catalog_property_unit_ax_catalo2` FOREIGN KEY (`catalog_property_unit_id`) REFERENCES `ax_catalog_property_unit` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO `ax_catalog_property_has_unit` (`catalog_property_id`, `catalog_property_unit_id`)
VALUES (3, 1),
       (4, 1),
       (5, 1),
       (6, 4);

DROP TABLE IF EXISTS `ax_catalog_property_type`;
CREATE TABLE `ax_catalog_property_type`
(
    `id`          bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `resource`    varchar(255)        NOT NULL COMMENT 'Таблица в которой лежит value',
    `title`       varchar(255)        NOT NULL,
    `description` varchar(255)     DEFAULT NULL,
    `sort`        int(11)          DEFAULT NULL,
    `image`       varchar(255)     DEFAULT NULL,
    `created_at`  int(11) unsigned DEFAULT NULL,
    `updated_at`  int(11) unsigned DEFAULT NULL,
    `deleted_at`  int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    UNIQUE KEY `title_UNIQUE` (`title`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO `ax_catalog_property_type` (`id`, `resource`, `title`, `description`, `sort`, `image`, `created_at`,
                                        `updated_at`, `deleted_at`)
VALUES (1, 'ax_catalog_product_has_value_varchar', 'Строка', NULL, 0, NULL, 1651608269, 1651608269, NULL),
       (2, 'ax_catalog_product_has_value_varchar', 'Ссылка', NULL, 6, NULL, 1651608269, 1651608269, NULL),
       (3, 'ax_catalog_product_has_value_int', 'Число', NULL, 1, NULL, 1651608269, 1651608269, NULL),
       (4, 'ax_catalog_product_has_value_decimal', 'Дробное число 0.00', NULL, 2, NULL, 1651608269, 1651608269, NULL),
       (5, 'ax_catalog_product_has_value_text', 'Большой текст', NULL, 3, NULL, 1651608269, 1651608269, NULL),
       (6, 'ax_catalog_product_has_value_varchar', 'Файл', NULL, 5, NULL, 1651608269, 1651608269, NULL),
       (7, 'ax_catalog_product_has_value_varchar', 'Изображение', NULL, 4, NULL, 1651608269, 1651608269, NULL);

DROP TABLE IF EXISTS `ax_catalog_property_unit`;
CREATE TABLE `ax_catalog_property_unit`
(
    `id`                   bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `unit_okei_id`         bigint(20) unsigned DEFAULT NULL,
    `title`                varchar(255)        NOT NULL,
    `national_symbol`      varchar(45)         DEFAULT NULL,
    `international_symbol` varchar(45)         DEFAULT NULL,
    `description`          varchar(255)        DEFAULT NULL,
    `sort`                 int(11)             DEFAULT NULL,
    `image`                varchar(255)        DEFAULT NULL,
    `created_at`           int(11) unsigned    DEFAULT NULL,
    `updated_at`           int(11) unsigned    DEFAULT NULL,
    `deleted_at`           int(11) unsigned    DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    KEY `fk_ax_catalog_property_unit_ax_unit_okei1_idx` (`unit_okei_id`),
    CONSTRAINT `fk_ax_catalog_property_unit_ax_unit_okei1` FOREIGN KEY (`unit_okei_id`) REFERENCES `ax_unit_okei` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO `ax_catalog_property_unit` (`id`, `unit_okei_id`, `title`, `national_symbol`, `international_symbol`,
                                        `description`, `sort`, `image`, `created_at`, `updated_at`, `deleted_at`)
VALUES (1, 1, 'Миллиметр', 'мм', 'ММ', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (2, 2, 'Сантиметр', 'см', 'СМ', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (3, 4, 'Метр', 'м', 'М', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (4, 36, 'Грамм', 'г', 'Г', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (5, 37, 'Килограмм', 'кг', 'КГ', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (6, 11, 'Квадратный миллиметр', 'мм^2', 'ММ2', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (7, 12, 'Квадратный сантиметр', 'см^2', 'СМ2', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (8, 14, 'Квадратный метр', 'м^2', 'М2', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (9, 121, 'Набор', 'набор', 'НАБОР', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (10, 122, 'Пара (2 шт.)', 'пар', 'ПАР', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (11, 131, 'Элемент', 'элем', 'ЭЛЕМ', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (12, 132, 'Упаковка', 'упак', 'УПАК', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (13, 135, 'Штука', 'шт', 'ШТ', NULL, NULL, NULL, 1651608270, 1651608270, NULL);

DROP TABLE IF EXISTS `ax_catalog_storage`;
CREATE TABLE `ax_catalog_storage`
(
    `id`                       bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `catalog_storage_place_id` bigint(20) unsigned NOT NULL,
    `catalog_product_id`       bigint(20) unsigned NOT NULL,
    `in_stock`                 int(11)             NOT NULL DEFAULT '0',
    `in_reserve`               int(11)                      DEFAULT '0',
    `reserve_expired_at`       int(11)                      DEFAULT NULL,
    `created_at`               int(11) unsigned             DEFAULT NULL,
    `updated_at`               int(11) unsigned             DEFAULT NULL,
    `deleted_at`               int(11) unsigned             DEFAULT NULL,
    PRIMARY KEY (`id`, `catalog_storage_place_id`, `catalog_product_id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    KEY `fk_ax_catalog_storage_ax_catalog_product1_idx` (`catalog_product_id`),
    KEY `fk_ax_catalog_storage_ax_catalog_storage_place1` (`catalog_storage_place_id`),
    CONSTRAINT `fk_ax_catalog_storage_ax_catalog_product1` FOREIGN KEY (`catalog_product_id`) REFERENCES `ax_catalog_product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_storage_ax_catalog_storage_place1` FOREIGN KEY (`catalog_storage_place_id`) REFERENCES `ax_catalog_storage_place` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO `ax_catalog_storage` (`id`, `catalog_storage_place_id`, `catalog_product_id`, `in_stock`, `in_reserve`,
                                  `reserve_expired_at`, `created_at`, `updated_at`, `deleted_at`)
VALUES (1, 1, 2, 1, 0, NULL, 1652123811, 1652123811, NULL),
       (2, 1, 7, 1, 0, NULL, 1652124172, 1652124172, NULL),
       (3, 1, 10, 1, 0, NULL, 1652124216, 1652124216, NULL),
       (4, 1, 9, 1, 0, NULL, 1652124229, 1652124229, NULL),
       (5, 1, 8, 1, 0, NULL, 1652124259, 1652124259, NULL),
       (6, 1, 6, 1, 0, NULL, 1652124282, 1652124282, NULL),
       (7, 1, 11, 1, 0, NULL, 1652124309, 1652124309, NULL),
       (8, 1, 4, 1, 0, NULL, 1652124321, 1652124321, NULL),
       (9, 1, 5, 1, 0, NULL, 1652124334, 1652124334, NULL),
       (10, 1, 12, 1, 0, NULL, 1652124450, 1652124450, NULL),
       (11, 1, 3, 1, 0, NULL, 1652124463, 1652124463, NULL);

DROP TABLE IF EXISTS `ax_catalog_storage_place`;
CREATE TABLE `ax_catalog_storage_place`
(
    `id`                       bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `catalog_storage_place_id` bigint(20) unsigned          DEFAULT NULL,
    `is_place`                 tinyint(1)          NOT NULL DEFAULT '0',
    `title`                    varchar(500)        NOT NULL,
    `created_at`               int(11) unsigned             DEFAULT NULL,
    `updated_at`               int(11) unsigned             DEFAULT NULL,
    `deleted_at`               int(11) unsigned             DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    KEY `fk_ax_catalog_storage_place_ax_catalog_storage_place1_idx` (`catalog_storage_place_id`),
    CONSTRAINT `fk_ax_catalog_storage_place_ax_catalog_storage_place1` FOREIGN KEY (`catalog_storage_place_id`) REFERENCES `ax_catalog_storage_place` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO `ax_catalog_storage_place` (`id`, `catalog_storage_place_id`, `is_place`, `title`, `created_at`,
                                        `updated_at`, `deleted_at`)
VALUES (1, NULL, 1, 'Главный склад', 1651608269, 1651608269, NULL);

DROP TABLE IF EXISTS `ax_comments`;
CREATE TABLE `ax_comments`
(
    `id`          bigint(20) unsigned NOT NULL,
    `resource`    varchar(255)        NOT NULL,
    `resource_id` bigint(20) unsigned NOT NULL,
    `person`      varchar(255)        NOT NULL,
    `person_id`   bigint(20)          NOT NULL,
    `comments_id` bigint(20) unsigned DEFAULT NULL,
    `ips_id`      bigint(20) unsigned DEFAULT NULL,
    `status`      tinyint(1) unsigned DEFAULT '0',
    `is_viewed`   tinyint(1)          DEFAULT '0',
    `text`        text                NOT NULL,
    `created_at`  int(11) unsigned    DEFAULT NULL,
    `updated_at`  int(11) unsigned    DEFAULT NULL,
    `deleted_at`  int(11) unsigned    DEFAULT NULL,
    PRIMARY KEY (`id`, `resource`, `resource_id`, `person_id`, `person`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    KEY `fk_ax_post_comments_ax_post_comments1_idx` (`comments_id`),
    KEY `fk_ax_post_comments_ax_ips1_idx` (`ips_id`),
    CONSTRAINT `fk_ax_post_comments_ax_ips1` FOREIGN KEY (`ips_id`) REFERENCES `ax_ips` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_post_comments_ax_post_comments1` FOREIGN KEY (`comments_id`) REFERENCES `ax_comments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_currency`;
CREATE TABLE `ax_currency`
(
    `id`         bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `global_id`  varchar(50)         NOT NULL,
    `num_code`   int(11)             NOT NULL,
    `char_code`  varchar(45)         NOT NULL,
    `title`      varchar(500)        NOT NULL,
    `created_at` int(11) unsigned DEFAULT NULL,
    `updated_at` int(11) unsigned DEFAULT NULL,
    `deleted_at` int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`, `global_id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    UNIQUE KEY `num_code_UNIQUE` (`num_code`),
    UNIQUE KEY `char_code_UNIQUE` (`char_code`),
    UNIQUE KEY `global_id_UNIQUE` (`global_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO `ax_currency` (`id`, `global_id`, `num_code`, `char_code`, `title`, `created_at`, `updated_at`,
                           `deleted_at`)
VALUES (1, 'R00000', 810, 'RUB', 'Российский рубль', 1651608268, 1651608268, NULL),
       (2, 'R01010', 36, 'AUD', 'Австралийский доллар', 1651608268, 1651608268, NULL),
       (3, 'R01020A', 944, 'AZN', 'Азербайджанский манат', 1651608268, 1651608268, NULL),
       (4, 'R01035', 826, 'GBP', 'Фунт стерлингов Соединенного королевства', 1651608268, 1651608268, NULL),
       (5, 'R01060', 51, 'AMD', 'Армянских драмов', 1651608268, 1651608268, NULL),
       (6, 'R01090B', 933, 'BYN', 'Белорусский рубль', 1651608268, 1651608268, NULL),
       (7, 'R01100', 975, 'BGN', 'Болгарский лев', 1651608268, 1651608268, NULL),
       (8, 'R01115', 986, 'BRL', 'Бразильский реал', 1651608268, 1651608268, NULL),
       (9, 'R01135', 348, 'HUF', 'Венгерских форинтов', 1651608268, 1651608268, NULL),
       (10, 'R01200', 344, 'HKD', 'Гонконгских долларов', 1651608268, 1651608268, NULL),
       (11, 'R01215', 208, 'DKK', 'Датская крона', 1651608268, 1651608268, NULL),
       (12, 'R01235', 840, 'USD', 'Доллар США', 1651608268, 1651608268, NULL),
       (13, 'R01239', 978, 'EUR', 'Евро', 1651608268, 1651608268, NULL),
       (14, 'R01270', 356, 'INR', 'Индийских рупий', 1651608268, 1651608268, NULL),
       (15, 'R01335', 398, 'KZT', 'Казахстанских тенге', 1651608268, 1651608268, NULL),
       (16, 'R01350', 124, 'CAD', 'Канадский доллар', 1651608268, 1651608268, NULL),
       (17, 'R01370', 417, 'KGS', 'Киргизских сомов', 1651608268, 1651608268, NULL),
       (18, 'R01375', 156, 'CNY', 'Китайский юань', 1651608268, 1651608268, NULL),
       (19, 'R01500', 498, 'MDL', 'Молдавских леев', 1651608268, 1651608268, NULL),
       (20, 'R01535', 578, 'NOK', 'Норвежских крон', 1651608268, 1651608268, NULL),
       (21, 'R01565', 985, 'PLN', 'Польский злотый', 1651608268, 1651608268, NULL),
       (22, 'R01585F', 946, 'RON', 'Румынский лей', 1651608268, 1651608268, NULL),
       (23, 'R01589', 960, 'XDR', 'СДР (специальные права заимствования)', 1651608268, 1651608268, NULL),
       (24, 'R01625', 702, 'SGD', 'Сингапурский доллар', 1651608268, 1651608268, NULL),
       (25, 'R01670', 972, 'TJS', 'Таджикских сомони', 1651608268, 1651608268, NULL),
       (26, 'R01700J', 949, 'TRY', 'Турецких лир', 1651608268, 1651608268, NULL),
       (27, 'R01710A', 934, 'TMT', 'Новый туркменский манат', 1651608268, 1651608268, NULL),
       (28, 'R01717', 860, 'UZS', 'Узбекских сумов', 1651608268, 1651608268, NULL),
       (29, 'R01720', 980, 'UAH', 'Украинских гривен', 1651608268, 1651608268, NULL),
       (30, 'R01760', 203, 'CZK', 'Чешских крон', 1651608268, 1651608268, NULL),
       (31, 'R01770', 752, 'SEK', 'Шведских крон', 1651608268, 1651608268, NULL),
       (32, 'R01775', 756, 'CHF', 'Швейцарский франк', 1651608268, 1651608268, NULL),
       (33, 'R01810', 710, 'ZAR', 'Южноафриканских рэндов', 1651608268, 1651608268, NULL),
       (34, 'R01815', 410, 'KRW', 'Вон Республики Корея', 1651608268, 1651608268, NULL),
       (35, 'R01820', 392, 'JPY', 'Японских иен', 1651608268, 1651608268, NULL);

DROP TABLE IF EXISTS `ax_currency_exchange_rate`;
CREATE TABLE `ax_currency_exchange_rate`
(
    `id`          bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `currency_id` bigint(20) unsigned NOT NULL,
    `value`       decimal(10, 0)      NOT NULL,
    `date_rate`   int(11) unsigned    NOT NULL,
    `created_at`  int(11) unsigned DEFAULT NULL,
    `updated_at`  int(11) unsigned DEFAULT NULL,
    `deleted_at`  int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`, `currency_id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    KEY `fk_ax_currency_exchange_rate_ax_currency1_idx` (`currency_id`),
    CONSTRAINT `fk_ax_currency_exchange_rate_ax_currency1` FOREIGN KEY (`currency_id`) REFERENCES `ax_currency` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO `ax_currency_exchange_rate` (`id`, `currency_id`, `value`, `date_rate`, `created_at`, `updated_at`,
                                         `deleted_at`)
VALUES (1, 2, 51, 1651266000, 1651608268, 1651608268, NULL),
       (2, 3, 42, 1651266000, 1651608268, 1651608268, NULL),
       (3, 4, 88, 1651266000, 1651608268, 1651608268, NULL),
       (4, 5, 16, 1651266000, 1651608268, 1651608268, NULL),
       (5, 6, 27, 1651266000, 1651608268, 1651608268, NULL),
       (6, 7, 38, 1651266000, 1651608268, 1651608268, NULL),
       (7, 8, 14, 1651266000, 1651608268, 1651608268, NULL),
       (8, 9, 20, 1651266000, 1651608268, 1651608268, NULL),
       (9, 10, 91, 1651266000, 1651608268, 1651608268, NULL),
       (10, 11, 10, 1651266000, 1651608268, 1651608268, NULL),
       (11, 12, 71, 1651266000, 1651608268, 1651608268, NULL),
       (12, 13, 75, 1651266000, 1651608268, 1651608268, NULL),
       (13, 14, 93, 1651266000, 1651608268, 1651608268, NULL),
       (14, 15, 16, 1651266000, 1651608268, 1651608268, NULL),
       (15, 16, 55, 1651266000, 1651608268, 1651608268, NULL),
       (16, 17, 87, 1651266000, 1651608268, 1651608268, NULL),
       (17, 18, 11, 1651266000, 1651608268, 1651608268, NULL),
       (18, 19, 38, 1651266000, 1651608268, 1651608268, NULL),
       (19, 20, 75, 1651266000, 1651608268, 1651608268, NULL),
       (20, 21, 16, 1651266000, 1651608268, 1651608268, NULL),
       (21, 22, 15, 1651266000, 1651608268, 1651608268, NULL),
       (22, 23, 95, 1651266000, 1651608268, 1651608268, NULL),
       (23, 24, 51, 1651266000, 1651608268, 1651608268, NULL),
       (24, 25, 57, 1651266000, 1651608268, 1651608268, NULL),
       (25, 26, 48, 1651266000, 1651608268, 1651608268, NULL),
       (26, 27, 20, 1651266000, 1651608268, 1651608268, NULL),
       (27, 28, 64, 1651266000, 1651608268, 1651608268, NULL),
       (28, 29, 23, 1651266000, 1651608268, 1651608268, NULL),
       (29, 30, 30, 1651266000, 1651608268, 1651608268, NULL),
       (30, 31, 73, 1651266000, 1651608268, 1651608268, NULL),
       (31, 32, 73, 1651266000, 1651608268, 1651608268, NULL),
       (32, 33, 45, 1651266000, 1651608268, 1651608268, NULL),
       (33, 34, 57, 1651266000, 1651608268, 1651608268, NULL),
       (34, 35, 55, 1651266000, 1651608268, 1651608268, NULL);

DROP TABLE IF EXISTS `ax_fin_transaction_type`;
CREATE TABLE `ax_fin_transaction_type`
(
    `id`         bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `name`       varchar(45)         NOT NULL,
    `title`      varchar(500)        NOT NULL,
    `created_at` int(11) unsigned DEFAULT NULL,
    `updated_at` int(11) unsigned DEFAULT NULL,
    `deleted_at` int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO `ax_fin_transaction_type` (`id`, `name`, `title`, `created_at`, `updated_at`, `deleted_at`)
VALUES (1, 'debit', 'Расход', 1651608268, 1651608268, NULL),
       (2, 'credit', 'Приход', 1651608268, 1651608268, NULL);

DROP TABLE IF EXISTS `ax_gallery`;
CREATE TABLE `ax_gallery`
(
    `id`          bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `title`       varchar(255)     DEFAULT NULL,
    `description` text,
    `sort`        int(11)          DEFAULT '0',
    `image`       varchar(500)     DEFAULT NULL,
    `url`         varchar(255)     DEFAULT NULL,
    `created_at`  int(11) unsigned DEFAULT NULL,
    `updated_at`  int(11) unsigned DEFAULT NULL,
    `deleted_at`  int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO `ax_gallery` (`id`, `title`, `description`, `sort`, `image`, `url`, `created_at`, `updated_at`,
                          `deleted_at`)
VALUES (1, 'Портфолио', NULL, 0, NULL, NULL, 1651608268, 1651608268, NULL),
       (38, '✶ Воробушек ✶', NULL, 0, NULL, NULL, 1651692611, 1651692611, NULL),
       (39, '✶ Закат ✶', NULL, 0, NULL, NULL, 1651693175, 1651693175, NULL),
       (40, '✶ Розмарин ✶', NULL, 0, NULL, NULL, 1651693957, 1651693957, NULL),
       (41, '✶ Круассан ✶', NULL, 0, NULL, NULL, 1651694072, 1651694072, NULL),
       (42, '✶ Артишок ✶', NULL, 0, NULL, NULL, 1651694241, 1651694241, NULL),
       (43, '✶ Морковь ✶', NULL, 0, NULL, NULL, 1651694563, 1651694563, NULL),
       (44, '✶ Сыр ✶', NULL, 0, NULL, NULL, 1651694793, 1651694793, NULL),
       (45, '✶ Форель ✶', NULL, 0, NULL, NULL, 1651696120, 1651696120, NULL),
       (46, '✶ Штопор ✶', NULL, 0, NULL, NULL, 1651696887, 1651696887, NULL),
       (47, '✶ Папоротник ✶', NULL, 0, NULL, NULL, 1651697509, 1651697509, NULL),
       (48, '✶ Глаз зебры ✶', NULL, 0, NULL, NULL, 1651698934, 1651698934, NULL);

DROP TABLE IF EXISTS `ax_gallery_has_resource`;
CREATE TABLE `ax_gallery_has_resource`
(
    `gallery_id`  bigint(20) unsigned NOT NULL,
    `resource`    varchar(255)        NOT NULL,
    `resource_id` bigint(20) unsigned NOT NULL,
    PRIMARY KEY (`gallery_id`, `resource`, `resource_id`),
    KEY `fk_ax_gallery_has_resource_ax_gallery1_idx` (`gallery_id`),
    CONSTRAINT `fk_ax_gallery_has_resource_ax_gallery1` FOREIGN KEY (`gallery_id`) REFERENCES `ax_gallery` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO `ax_gallery_has_resource` (`gallery_id`, `resource`, `resource_id`)
VALUES (1, 'ax_page', 2),
       (38, 'ax_catalog_product', 8),
       (39, 'ax_catalog_product', 2),
       (40, 'ax_catalog_product', 3),
       (41, 'ax_catalog_product', 4),
       (42, 'ax_catalog_product', 5),
       (43, 'ax_catalog_product', 6),
       (44, 'ax_catalog_product', 7),
       (45, 'ax_catalog_product', 9),
       (46, 'ax_catalog_product', 10),
       (47, 'ax_catalog_product', 11),
       (48, 'ax_catalog_product', 12);

DROP TABLE IF EXISTS `ax_gallery_image`;
CREATE TABLE `ax_gallery_image`
(
    `id`          bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `gallery_id`  bigint(20) unsigned NOT NULL,
    `image`       varchar(255)        NOT NULL,
    `title`       varchar(255)     DEFAULT NULL,
    `description` text,
    `sort`        int(11)          DEFAULT '0',
    `created_at`  int(11) unsigned DEFAULT NULL,
    `updated_at`  int(11) unsigned DEFAULT NULL,
    `deleted_at`  int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`, `gallery_id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    UNIQUE KEY `href_UNIQUE` (`image`),
    KEY `fk_ax_gallery_image_ax_gallery1_idx` (`gallery_id`),
    CONSTRAINT `fk_ax_gallery_image_ax_gallery1` FOREIGN KEY (`gallery_id`) REFERENCES `ax_gallery` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO `ax_gallery_image` (`id`, `gallery_id`, `image`, `title`, `description`, `sort`, `created_at`, `updated_at`,
                                `deleted_at`)
VALUES (1, 1, '/upload/ax_page/portfolio/cJtlLHiljk3DGMHPS0AlBDMVFbaYrpbnEvqHSrWW.jpeg', NULL, NULL, NULL, 1651608268,
        1651608268, NULL),
       (2, 1, '/upload/ax_page/portfolio/4eglk2kDJMd2T8oPTx0c9CVVdpShk6IRXftPkqsk.jpeg', NULL, NULL, NULL, 1651608268,
        1651608268, NULL),
       (3, 1, '/upload/ax_page/portfolio/DXSDTbeAdneH1a3JSGq98VY3p6lU4GI1I2vxmBGD.jpeg', NULL, NULL, NULL, 1651608268,
        1651608268, NULL),
       (4, 1, '/upload/ax_page/portfolio/Aw1KfRyrhTF2BSA2yiqfXqhHqZSq3PSiBLkyPLiZ.jpeg', NULL, NULL, NULL, 1651608268,
        1651608268, NULL),
       (5, 1, '/upload/ax_page/portfolio/EmtnVeWpapcZUfPphxg8dYIya3MyZ6BfDW5NSspw.jpeg', NULL, NULL, NULL, 1651608268,
        1651608268, NULL),
       (6, 1, '/upload/ax_page/portfolio/Dr56YHLpDrUNOqZyVKyM4ej8dw3eqtpktnBtrDSN.jpeg', NULL, NULL, NULL, 1651608268,
        1651608268, NULL),
       (7, 1, '/upload/ax_page/portfolio/HtqIVmDUMivPeiasHGfU06WD2gLnOhlbKMaavHsS.jpeg', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (8, 1, '/upload/ax_page/portfolio/VnEt0OgpXnhhEkDo8pYT8QKQz3nhEehaTXideaK9.jpeg', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (9, 1, '/upload/ax_page/portfolio/3LhD5dRYOr7DV1mlJVeCO0mRewSz9spXVzcAQxPx.jpeg', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (10, 1, '/upload/ax_page/portfolio/oKrPBpaCll7QfiUTsZBwWB3Z13O3lYNTpdvM8TR9.jpeg', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (11, 1, '/upload/ax_page/portfolio/hnfBB8aOuNXMXRuOLbsIXsRmNs4Uuw4v8x51He5K.jpeg', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (12, 1, '/upload/ax_page/portfolio/cM0cQHoDdlZR8hmVUAFbuFUZCzBYgI4uN4l6gebK.jpeg', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (13, 1, '/upload/ax_page/portfolio/ap7k9JbFhosEGZEHrwyixUVXEWZkXtMvnFD82b2n.jpeg', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (16, 38, '/upload/ax_catalog_product/vorobushek/2UM3JytzjVrf95hnMpMuifc4IFB87wTimFrhCMGY.jpeg', NULL, NULL, NULL,
        1651692611, 1651692611, NULL),
       (17, 38, '/upload/ax_catalog_product/vorobushek/c7Flew4LcGCB6htoh1vtX4jxrkpIcbBsAJVJJcvL.jpeg', NULL, NULL, NULL,
        1651692611, 1651692611, NULL),
       (18, 38, '/upload/ax_catalog_product/vorobushek/3ZdjvvvFGw5SKSJZLqgMJbfvSXqHsASAqgCbCohz.jpeg', NULL, NULL, NULL,
        1651692611, 1651692611, NULL),
       (19, 39, '/upload/ax_catalog_product/zakat/g46EXwRf8xVQ93SvIr2MhvNiywJPUwvlgrblKjU1.jpeg', NULL, NULL, NULL,
        1651693175, 1651693175, NULL),
       (20, 40, '/upload/ax_catalog_product/rozmarin/fKl6bydY0qsxU4gbZweRULPdi4xW5OQFA1YOg78T.jpeg', NULL, NULL, NULL,
        1651693957, 1651693957, NULL),
       (21, 41, '/upload/ax_catalog_product/kruassan/ozFDdHJcWVOH8w2arJuuBwqtEgr8zQXNBhHJhU7J.jpeg', NULL, NULL, NULL,
        1651694072, 1651694072, NULL),
       (22, 42, '/upload/ax_catalog_product/artishok/f1nroxsMrpQeNmeYaQje5UirQEMExBawhmIdht3c.jpeg', NULL, NULL, NULL,
        1651694241, 1651694241, NULL),
       (23, 43, '/upload/ax_catalog_product/morkov/gx9I6UvoaYQJi7QOeIsIazzkyp5zHiyKKi0WYDeY.jpeg', NULL, NULL, NULL,
        1651694563, 1651694563, NULL),
       (24, 44, '/upload/ax_catalog_product/syr/B82c1WPW25LFBkYL4qLgPsCZ0Gai6FTtNLRnkqbV.jpeg', NULL, NULL, NULL,
        1651694793, 1651694793, NULL),
       (25, 45, '/upload/ax_catalog_product/forel/agIxNqwvtdF9RM4Zj2QRbPPA03SrEIHNUhaxLJRU.jpeg', NULL, NULL, NULL,
        1651696120, 1651696120, NULL),
       (26, 46, '/upload/ax_catalog_product/shtopor/QpmjhhXQeKmQ0GKab6HN0dKZuRw1yRpks132pe5c.jpeg', NULL, NULL, NULL,
        1651696887, 1651696887, NULL),
       (27, 47, '/upload/ax_catalog_product/paporotnik/vueeJZnbmYmBOfLHgPj4jmPx8AXOTIbswK2TiDUG.jpeg', NULL, NULL, NULL,
        1651697509, 1651697509, NULL),
       (28, 47, '/upload/ax_catalog_product/paporotnik/IKBbXDrUpCXrZHsAnB9akRxMsobq0UzkS2UCmA3N.jpeg', NULL, NULL, NULL,
        1651697509, 1651697509, NULL),
       (29, 48, '/upload/ax_catalog_product/glaz-zebry/CCv0orsGs1iRL7BLatOS6IKolay8uu9KCpSJOqY9.jpeg', NULL, NULL, NULL,
        1651698934, 1651698934, NULL);

DROP TABLE IF EXISTS `ax_ips`;
CREATE TABLE `ax_ips`
(
    `id`         bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `ip`         varchar(255)        NOT NULL,
    `status`     tinyint(1)       DEFAULT '1',
    `created_at` int(11) unsigned DEFAULT NULL,
    `updated_at` int(11) unsigned DEFAULT NULL,
    `deleted_at` int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    UNIQUE KEY `ip_UNIQUE` (`ip`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO `ax_ips` (`id`, `ip`, `status`, `created_at`, `updated_at`, `deleted_at`)
VALUES (1, '46.159.206.136', 1, 1652123811, 1652123811, NULL);

DROP TABLE IF EXISTS `ax_ips_has_resource`;
CREATE TABLE `ax_ips_has_resource`
(
    `ips_id`      bigint(20) unsigned NOT NULL,
    `resource`    varchar(255)        NOT NULL,
    `resource_id` bigint(20) unsigned NOT NULL,
    PRIMARY KEY (`ips_id`, `resource`, `resource_id`),
    KEY `fk_ax_ips_has_ax_visitors_ax_ips1_idx` (`ips_id`),
    CONSTRAINT `fk_ax_ips_has_ax_visitors_ax_ips1` FOREIGN KEY (`ips_id`) REFERENCES `ax_ips` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_letters`;
CREATE TABLE `ax_letters`
(
    `id`          bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `resource`    varchar(255)        NOT NULL,
    `resource_id` bigint(20) unsigned NOT NULL,
    `person`      varchar(255)        NOT NULL,
    `person_id`   bigint(20)          NOT NULL,
    `ips_id`      bigint(20) unsigned DEFAULT NULL,
    `subject`     varchar(255)        DEFAULT NULL,
    `text`        text,
    `is_viewed`   tinyint(1)          DEFAULT '0',
    `created_at`  int(11) unsigned    DEFAULT NULL,
    `updated_at`  int(11) unsigned    DEFAULT NULL,
    `deleted_at`  int(11) unsigned    DEFAULT NULL,
    PRIMARY KEY (`id`, `resource`, `resource_id`, `person`, `person_id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    KEY `fk_ax_letters_ax_ips1_idx` (`ips_id`),
    CONSTRAINT `fk_ax_letters_ax_ips1` FOREIGN KEY (`ips_id`) REFERENCES `ax_ips` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_menu`;
CREATE TABLE `ax_menu`
(
    `id`          bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `title`       varchar(255)        NOT NULL,
    `name`        varchar(45)         NOT NULL,
    `description` varchar(255)     DEFAULT NULL,
    `created_at`  int(11) unsigned DEFAULT NULL,
    `updated_at`  int(11) unsigned DEFAULT NULL,
    `deleted_at`  int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    UNIQUE KEY `title_UNIQUE` (`title`),
    UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_menu_has_resource`;
CREATE TABLE `ax_menu_has_resource`
(
    `menu_id`     bigint(20) unsigned NOT NULL,
    `resource`    varchar(255)        NOT NULL,
    `resource_id` bigint(20) unsigned NOT NULL,
    PRIMARY KEY (`menu_id`, `resource`, `resource_id`),
    KEY `fk_ax_menu_has_ax_post_category_ax_menu1_idx` (`menu_id`),
    CONSTRAINT `fk_ax_menu_has_ax_post_category_ax_menu10` FOREIGN KEY (`menu_id`) REFERENCES `ax_menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_menu_item`;
CREATE TABLE `ax_menu_item`
(
    `id`           bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `menu_id`      bigint(20) unsigned NOT NULL,
    `menu_item_id` bigint(20) unsigned DEFAULT NULL,
    `resource`     varchar(255)        DEFAULT NULL,
    `resource_id`  bigint(20) unsigned DEFAULT NULL,
    `title`        varchar(255)        NOT NULL,
    `sort`         int(11)             DEFAULT '0',
    `url`          varchar(255)        NOT NULL,
    `created_at`   int(11) unsigned    DEFAULT NULL,
    `updated_at`   int(11) unsigned    DEFAULT NULL,
    `deleted_at`   int(11) unsigned    DEFAULT NULL,
    PRIMARY KEY (`id`, `menu_id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    KEY `fk_ax_menu_item_ax_menu1_idx` (`menu_id`),
    KEY `fk_ax_menu_item_ax_menu_item1_idx` (`menu_item_id`),
    CONSTRAINT `fk_ax_menu_item_ax_menu1` FOREIGN KEY (`menu_id`) REFERENCES `ax_menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_menu_item_ax_menu_item1` FOREIGN KEY (`menu_item_id`) REFERENCES `ax_menu_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_migrations`;
CREATE TABLE `ax_migrations`
(
    `id`        bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `migration` varchar(255)        NOT NULL,
    `batch`     int(11)             NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO `ax_migrations` (`id`, `migration`, `batch`)
VALUES (1, '2022_01_01_075639_first_dump', 1),
       (2, '2022_03_22_162143_create_permission_tables', 1),
       (3, '2022_04_02_095219_insert_permission_tables', 1),
       (4, '2022_04_07_182444_insert_first_data', 1),
       (5, '2019_12_14_000001_create_personal_access_tokens_table', 2),
       (6, '2022_05_09_193948_create_fix_address_coupon_document_storage', 2);

DROP TABLE IF EXISTS `ax_page`;
CREATE TABLE `ax_page`
(
    `id`              bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `user_id`         bigint(20) unsigned NOT NULL,
    `page_type_id`    bigint(20) unsigned NOT NULL,
    `render_id`       bigint(20) unsigned DEFAULT NULL,
    `is_published`    tinyint(1) unsigned DEFAULT '1',
    `is_favourites`   tinyint(1) unsigned DEFAULT '0',
    `is_comments`     tinyint(1) unsigned DEFAULT '0',
    `is_watermark`    tinyint(1) unsigned DEFAULT '1',
    `url`             varchar(500)        NOT NULL,
    `alias`           varchar(255)        NOT NULL,
    `title`           varchar(255)        NOT NULL,
    `title_short`     varchar(155)        DEFAULT NULL,
    `description`     text,
    `title_seo`       varchar(255)        DEFAULT NULL,
    `description_seo` varchar(255)        DEFAULT NULL,
    `image`           varchar(255)        DEFAULT NULL,
    `media`           varchar(255)        DEFAULT NULL,
    `hits`            int(11) unsigned    DEFAULT '0',
    `sort`            int(11)             DEFAULT '0',
    `created_at`      int(11) unsigned    DEFAULT NULL,
    `updated_at`      int(11) unsigned    DEFAULT NULL,
    `deleted_at`      int(11) unsigned    DEFAULT NULL,
    PRIMARY KEY (`id`, `user_id`, `page_type_id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    UNIQUE KEY `alias_UNIQUE` (`alias`),
    UNIQUE KEY `url_UNIQUE` (`url`),
    KEY `fk_ax_post_ax_user1_idx` (`user_id`),
    KEY `fk_ax_post_ax_render1_idx` (`render_id`),
    KEY `fk_ax_page_ax_page_type1_idx` (`page_type_id`),
    CONSTRAINT `fk_ax_page_ax_page_type1` FOREIGN KEY (`page_type_id`) REFERENCES `ax_page_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_post_ax_render10` FOREIGN KEY (`render_id`) REFERENCES `ax_render` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_post_ax_user10` FOREIGN KEY (`user_id`) REFERENCES `ax_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO `ax_page` (`id`, `user_id`, `page_type_id`, `render_id`, `is_published`, `is_favourites`, `is_comments`,
                       `is_watermark`, `url`, `alias`, `title`, `title_short`, `description`, `title_seo`,
                       `description_seo`, `image`, `media`, `hits`, `sort`, `created_at`, `updated_at`, `deleted_at`)
VALUES (1, 6, 3, 1, 0, 0, 0, 0, 'history', 'history', 'История', NULL,
        '\n            <p class=\"history__paragraph\">\n                Привет, я Ира, и я делаю кухонные доски для Вас.\n            </p>\n            <p class=\"history__paragraph\">\n                Расскажу вам краткую историю как все началось.\n            </p>\n            <p class=\"history__paragraph\">\n                Возвращаясь после очередной поездки в горы, заряженные энергией природы, мы с супругом, как всегда,\n                всю дорогу разговаривали, обсуждая наши планы и как их можно реализовать.\n            </p>\n            <p class=\"history__paragraph\">\n                В один момент говорю ему, я хочу что-то создавать! Создавать сама, создавать такое, чтоб нравилось мне, чтоб получала удовольствие от процесса, и чтобы это было нужно и полезно людям.\n            </p>\n            <p class=\"history__paragraph\">\n                На тот момент я даже не подозревала о своей любви к дереву, что смогу работать с таки не простым материалом, ведь это совсем не легкий труд и прямо скажем не для девочки.\n            </p>\n            <p class=\"history__paragraph\">\n                В это время я трудилась в компании, в чистом, комфортном офисе.\n                Я понятия не имела что такого хочу создавать, но создавать я хотела это точно.\n            </p>\n            <p class=\"history__paragraph\">\n                Так произошло, что, приехав в гости к родителям, мы обнаружили у них в подвале доски из дуба, которые папа зачем-то туда положил много лет назад. И эти доски поехали к нам.\n            </p>\n            <p class=\"history__paragraph\">\n                Дело было перед новым годом, и мы решили из этого дуба сделать всем родным подарки в виде торцевых разделочных досок. Даже и не знаю почему мы это решили, наверное, судьба.\n            </p>\n            <p class=\"history__paragraph\">\n                Посмотрев кучу видео, как сие чудо делается, мы принялись за дело.\n                И у нас получилось это самое чудо, не с первого раза конечно, но получилось.\n            </p>\n            <p class=\"history__paragraph\">\n                Родные были в восторге от таких подарков, не веря, что они сделаны нами. Но мы были убедительны.\n            </p>\n            <p class=\"history__paragraph\">\n                Мне настолько понравился процесс их создания, я была полностью захвачена им. Особенно моментом, после финального распила, когда бруски переворачиваются торцами вверх, происходит магия. Появляется рисунок, рисунок, который создала сама природа. Он прекрасен, и повторить его невозможно, от слова совсем. Наверное, в этот момент я обнаружила свою страсть и любовь к этому замечательному ремеслу.\n            </p>\n            <p class=\"history__paragraph\">\n                Так как у супруга нет времени мне помогать, и я взялась за дело сама.\n            </p>\n            <p class=\"history__paragraph\">\n                Выяснилось, что не получится совмещать работу с деревом и работу в офисе, мы приняли решение о моем увольнение, и я ушла с основного места работы в свободное плавание, в шумную, пыльную мастерскую.\n            </p>\n            <p class=\"history__paragraph\">\n                Так я начала делать торцевые разделочные доски.\n            </p>\n            <p class=\"history__paragraph\">\n                В один прекрасный момент, мне попалась широкая необрезная доска, отстрогав ее я увидела потрясающий рисунок дерева, решила его не распускать на брус, а отложить.\n            </p>\n            <p class=\"history__paragraph\">\n                Так пришла мысль сделать доску из массива.\n            </p>\n            <p class=\"history__paragraph\">\n                Изготовив несколько досок, захотелось добавить что-то, какую-то изюминку, вишенку на торте.\n            </p>\n            <p class=\"history__paragraph\">\n                Пришла идея нанести рисунок с помощью обычного советского выжигателя.\n                Фокус не удался, мощность маловата, доска же из дуба.\n            </p>\n            <p class=\"history__paragraph\">\n                Так я приобрела себе профессиональный пирограф.\n            </p>\n            <p class=\"history__paragraph\">\n                С ним все получилось и понеслось. Хотелось выжигать на всех досках, а так как на торцевых такой возможности нет, я перешла на изделия из массива.\n            </p>\n            <p class=\"history__paragraph\">\n                Выпиливаю разные формы, подбираю к каждой рисунок, и получается вот такая уникальная доска, единственная в своем роде.\n            </p>\n            <p class=\"history__paragraph\">\n                Вот краткая история как я нашла себя в деревообработке.\n            </p>\n            <p class=\"history__paragraph\">\n                Все изделия, которые видите на сайте, сделано мной вручную. Я не пользуюсь современным оборудованием, которым управляет компьютер, станок с ЧПУ и лазер.\n            </p>\n            <p class=\"history__paragraph\">\n                Это говорит о том, что изделия не будут абсолютно одинаковыми.\n            </p>\n            <p class=\"history__paragraph\">\n                Форму доски подсказывает само дерево, рисунок наношу пирографом (возжигателем).\n            </p>\n            <p class=\"history__paragraph\">\n                В финишной обработке предпочитаю использовать только натуральные и безопасные материалы для человека и его здоровья.\n                Всё, чего касаются продукты, должно быть безопасным.\n            </p>\n            <p class=\"history__paragraph\">\n                Я против тонирующих и красящих веществ на химической основе. Да, они придают красивые цвета и оттенки, но как по мне, это не безопасно.\n            </p>\n            <p class=\"history__paragraph\">\n                Все цвета изделий что вы видите, это натуральный цвет дерева.\n            </p>\n            <p class=\"history__paragraph\">\n                Как сказал мой коллега: «Я считаю, что истинное мастерство, функциональность и простота, которые воплощают в жизнь ремесленные изделия, являются наиболее важными аспектами деревообработки.»\n            </p>\n        ',
        NULL, NULL, NULL, NULL, 0, NULL, 1651608268, 1651608268, NULL),
       (2, 6, 3, 2, 0, 0, 0, 0, 'portfolio', 'portfolio', 'Портфолио', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL,
        1651608268, 1651608268, NULL),
       (3, 6, 3, 3, 0, 0, 0, 0, 'contact', 'contact', 'Контакты', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL,
        1651608269, 1651608269, NULL);

DROP TABLE IF EXISTS `ax_page_type`;
CREATE TABLE `ax_page_type`
(
    `id`          bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `resource`    varchar(255)        NOT NULL,
    `title`       varchar(255)        NOT NULL,
    `description` text,
    `created_at`  int(11) unsigned DEFAULT NULL,
    `updated_at`  int(11) unsigned DEFAULT NULL,
    `deleted_at`  int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO `ax_page_type` (`id`, `resource`, `title`, `description`, `created_at`, `updated_at`, `deleted_at`)
VALUES (1, 'ax_post_category', 'Входная страница блога', NULL, 1651608268, 1651608268, NULL),
       (2, 'ax_catalog_category', 'Входная страница магазина', NULL, 1651608268, 1651608268, NULL),
       (3, 'ax_page', 'Текстовая страница', NULL, 1651608268, 1651608268, NULL);

DROP TABLE IF EXISTS `ax_phone`;
CREATE TABLE `ax_phone`
(
    `id`         bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `number`     varchar(45)         NOT NULL,
    `created_at` int(11) unsigned DEFAULT NULL,
    `updated_at` int(11) unsigned DEFAULT NULL,
    `deleted_at` int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    UNIQUE KEY `number_UNIQUE` (`number`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_phone_has_resource`;
CREATE TABLE `ax_phone_has_resource`
(
    `phone_id`    bigint(20) unsigned NOT NULL,
    `resource`    varchar(255)        NOT NULL,
    `resource_id` bigint(20) unsigned NOT NULL,
    PRIMARY KEY (`phone_id`, `resource`, `resource_id`),
    KEY `fk_ax_phone_has_resource_ax_phone1_idx` (`phone_id`),
    CONSTRAINT `fk_ax_phone_has_resource_ax_phone1` FOREIGN KEY (`phone_id`) REFERENCES `ax_phone` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_post`;
CREATE TABLE `ax_post`
(
    `id`                  bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `user_id`             bigint(20) unsigned NOT NULL,
    `render_id`           bigint(20) unsigned  DEFAULT NULL,
    `category_id`         bigint(20) unsigned  DEFAULT NULL,
    `is_published`        tinyint(1) unsigned  DEFAULT '1',
    `is_favourites`       tinyint(1) unsigned  DEFAULT '0',
    `is_comments`         tinyint(1) unsigned  DEFAULT '0',
    `is_image_post`       tinyint(1) unsigned  DEFAULT '1',
    `is_image_category`   tinyint(1) unsigned  DEFAULT '1',
    `is_watermark`        tinyint(1) unsigned  DEFAULT '1',
    `media`               varchar(255)         DEFAULT NULL,
    `url`                 varchar(500)        NOT NULL,
    `alias`               varchar(255)        NOT NULL,
    `title`               varchar(255)        NOT NULL,
    `title_short`         varchar(155)         DEFAULT NULL,
    `preview_description` text,
    `description`         text,
    `title_seo`           varchar(255)         DEFAULT NULL,
    `description_seo`     varchar(255)         DEFAULT NULL,
    `show_date`           tinyint(1)           DEFAULT '1',
    `date_pub`            int(11)              DEFAULT '0',
    `date_end`            int(11)              DEFAULT '0',
    `control_date_pub`    tinyint(1)           DEFAULT '0',
    `control_date_end`    tinyint(1)           DEFAULT '0',
    `image`               varchar(255)         DEFAULT NULL,
    `hits`                int(11) unsigned     DEFAULT '0',
    `sort`                int(11)              DEFAULT '0',
    `stars`               float(1, 1) unsigned DEFAULT '0.0',
    `created_at`          int(11) unsigned     DEFAULT NULL,
    `updated_at`          int(11) unsigned     DEFAULT NULL,
    `deleted_at`          int(11) unsigned     DEFAULT NULL,
    PRIMARY KEY (`id`, `user_id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    UNIQUE KEY `alias_UNIQUE` (`alias`),
    UNIQUE KEY `url_UNIQUE` (`url`),
    KEY `fk_ax_post_ax_user1_idx` (`user_id`),
    KEY `fk_ax_post_ax_render1_idx` (`render_id`),
    KEY `fk_ax_post_ax_post_category1_idx` (`category_id`),
    CONSTRAINT `fk_ax_post_ax_post_category1` FOREIGN KEY (`category_id`) REFERENCES `ax_post_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_post_ax_render1` FOREIGN KEY (`render_id`) REFERENCES `ax_render` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_post_ax_user1` FOREIGN KEY (`user_id`) REFERENCES `ax_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_post_category`;
CREATE TABLE `ax_post_category`
(
    `id`                  bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `category_id`         bigint(20) unsigned DEFAULT NULL,
    `render_id`           bigint(20) unsigned DEFAULT NULL,
    `is_published`        tinyint(1) unsigned DEFAULT '1',
    `is_favourites`       tinyint(1) unsigned DEFAULT '0',
    `is_watermark`        tinyint(1)          DEFAULT '1',
    `image`               varchar(255)        DEFAULT NULL,
    `show_image`          tinyint(1)          DEFAULT '1',
    `url`                 varchar(500)        NOT NULL,
    `alias`               varchar(255)        NOT NULL,
    `title`               varchar(255)        NOT NULL,
    `title_short`         varchar(150)        DEFAULT NULL,
    `description`         text,
    `preview_description` text,
    `title_seo`           varchar(255)        DEFAULT NULL,
    `description_seo`     varchar(255)        DEFAULT NULL,
    `sort`                tinyint(3) unsigned DEFAULT '0',
    `created_at`          int(11) unsigned    DEFAULT NULL,
    `updated_at`          int(11) unsigned    DEFAULT NULL,
    `deleted_at`          int(11) unsigned    DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    UNIQUE KEY `alias_UNIQUE` (`alias`),
    UNIQUE KEY `url_UNIQUE` (`url`),
    KEY `fk_ax_post_category_ax_render1_idx` (`render_id`),
    KEY `fk_ax_post_category_ax_post_category1_idx` (`category_id`),
    CONSTRAINT `fk_ax_post_category_ax_post_category1` FOREIGN KEY (`category_id`) REFERENCES `ax_post_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_post_category_ax_render1` FOREIGN KEY (`render_id`) REFERENCES `ax_render` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_redirect`;
CREATE TABLE `ax_redirect`
(
    `id`         bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `url`        varchar(500)        NOT NULL,
    `url_old`    varchar(500)        NOT NULL,
    `created_at` int(11) unsigned DEFAULT NULL,
    `updated_at` int(11) unsigned DEFAULT NULL,
    `deleted_at` int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_render`;
CREATE TABLE `ax_render`
(
    `id`         bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `title`      varchar(255)        NOT NULL,
    `name`       varchar(45)         NOT NULL,
    `resource`   varchar(255)     DEFAULT NULL,
    `created_at` int(11) unsigned DEFAULT NULL,
    `updated_at` int(11) unsigned DEFAULT NULL,
    `deleted_at` int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO `ax_render` (`id`, `title`, `name`, `resource`, `created_at`, `updated_at`, `deleted_at`)
VALUES (1, 'Шаблон для страницы \"История\"', 'history', 'ax_page', 1651608268, 1651608268, NULL),
       (2, 'Шаблон для страницы \"Портфолио\"', 'portfolio', 'ax_page', 1651608268, 1651608268, NULL),
       (3, 'Шаблон для страницы \"Контакты\"', 'contact', 'ax_page', 1651608268, 1651608268, NULL);

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `ax_rights_model_has_permissions`;
CREATE TABLE `ax_rights_model_has_permissions`
(
    `permission_id` bigint(20) unsigned                     NOT NULL,
    `model_type`    varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `model_id`      bigint(20) unsigned                     NOT NULL,
    PRIMARY KEY (`permission_id`, `model_id`, `model_type`),
    KEY `model_has_permissions_model_id_model_type_index` (`model_id`, `model_type`),
    CONSTRAINT `ax_rights_model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `ax_rights_permissions` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `ax_rights_model_has_roles`;
CREATE TABLE `ax_rights_model_has_roles`
(
    `role_id`    bigint(20) unsigned                     NOT NULL,
    `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `model_id`   bigint(20) unsigned                     NOT NULL,
    PRIMARY KEY (`role_id`, `model_id`, `model_type`),
    KEY `model_has_roles_model_id_model_type_index` (`model_id`, `model_type`),
    CONSTRAINT `ax_rights_model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `ax_rights_roles` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

INSERT INTO `ax_rights_model_has_roles` (`role_id`, `model_type`, `model_id`)
VALUES (1, 'App\\Common\\Models\\User\\UserWeb', 6),
       (2, 'App\\Common\\Models\\User\\UserWeb', 6);

DROP TABLE IF EXISTS `ax_rights_permissions`;
CREATE TABLE `ax_rights_permissions`
(
    `id`         bigint(20) unsigned                     NOT NULL AUTO_INCREMENT,
    `name`       varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp                               NULL DEFAULT NULL,
    `updated_at` timestamp                               NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `ax_rights_permissions_name_guard_name_unique` (`name`, `guard_name`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

INSERT INTO `ax_rights_permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`)
VALUES (1, 'entrance_allowed', 'web', '2022-05-03 20:04:28', '2022-05-03 20:04:28');

DROP TABLE IF EXISTS `ax_rights_roles`;
CREATE TABLE `ax_rights_roles`
(
    `id`         bigint(20) unsigned                     NOT NULL AUTO_INCREMENT,
    `name`       varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp                               NULL DEFAULT NULL,
    `updated_at` timestamp                               NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `ax_rights_roles_name_guard_name_unique` (`name`, `guard_name`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

INSERT INTO `ax_rights_roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`)
VALUES (1, 'admin', 'web', '2022-05-03 20:04:28', '2022-05-03 20:04:28'),
       (2, 'employee', 'web', '2022-05-03 20:04:28', '2022-05-03 20:04:28');

DROP TABLE IF EXISTS `ax_rights_role_has_permissions`;
CREATE TABLE `ax_rights_role_has_permissions`
(
    `permission_id` bigint(20) unsigned NOT NULL,
    `role_id`       bigint(20) unsigned NOT NULL,
    PRIMARY KEY (`permission_id`, `role_id`),
    KEY `ax_rights_role_has_permissions_role_id_foreign` (`role_id`),
    CONSTRAINT `ax_rights_role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `ax_rights_permissions` (`id`) ON DELETE CASCADE,
    CONSTRAINT `ax_rights_role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `ax_rights_roles` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

INSERT INTO `ax_rights_role_has_permissions` (`permission_id`, `role_id`)
VALUES (1, 2);

DROP TABLE IF EXISTS `ax_settings`;
CREATE TABLE `ax_settings`
(
    `id`                   bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `currency_update_rate` int(11)             DEFAULT NULL,
    `script`               longtext,
    `css`                  longtext,
    `robots`               text,
    `google_verification`  varchar(255)        DEFAULT NULL,
    `yandex_verification`  varchar(255)        DEFAULT NULL,
    `yandex_metrika`       text,
    `google_analytics`     text,
    `logo_general`         varchar(255)        DEFAULT NULL,
    `logo_second`          varchar(255)        DEFAULT NULL,
    `company_name`         varchar(255)        DEFAULT NULL,
    `company_name_full`    varchar(500)        DEFAULT NULL,
    `company_phone`        varchar(255)        DEFAULT NULL,
    `company_email`        varchar(500)        DEFAULT NULL,
    `company_address`      varchar(500)        DEFAULT NULL,
    `redirect_on`          tinyint(1) unsigned DEFAULT '1',
    `created_at`           int(11) unsigned    DEFAULT NULL,
    `updated_at`           int(11) unsigned    DEFAULT NULL,
    `deleted_at`           int(11) unsigned    DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_tags`;
CREATE TABLE `ax_tags`
(
    `id`              bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `is_sitemap`      tinyint(1)          DEFAULT '1',
    `is_published`    tinyint(1) unsigned DEFAULT '1',
    `is_favourites`   tinyint(1) unsigned DEFAULT '0',
    `is_watermark`    tinyint(1)          DEFAULT '1',
    `image`           varchar(255)        DEFAULT NULL,
    `show_image`      tinyint(1)          DEFAULT '1',
    `alias`           varchar(255)        NOT NULL,
    `title`           varchar(255)        NOT NULL,
    `title_short`     varchar(150)        DEFAULT NULL,
    `description`     text,
    `title_seo`       varchar(255)        DEFAULT NULL,
    `description_seo` varchar(255)        DEFAULT NULL,
    `sort`            tinyint(3) unsigned DEFAULT '0',
    `created_at`      int(11) unsigned    DEFAULT NULL,
    `updated_at`      int(11) unsigned    DEFAULT NULL,
    `deleted_at`      int(11) unsigned    DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    UNIQUE KEY `title_UNIQUE` (`title`),
    UNIQUE KEY `alias_UNIQUE` (`alias`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_tags_has_resource`;
CREATE TABLE `ax_tags_has_resource`
(
    `tags_id`     bigint(20) unsigned NOT NULL,
    `resource`    varchar(255)        NOT NULL,
    `resource_id` bigint(20) unsigned NOT NULL,
    PRIMARY KEY (`tags_id`, `resource`, `resource_id`),
    KEY `fk_ax_post_has_ax_post_tags_ax_post_tags1_idx` (`tags_id`),
    CONSTRAINT `fk_ax_post_has_ax_post_tags_ax_post_tags1` FOREIGN KEY (`tags_id`) REFERENCES `ax_tags` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_unit_okei`;
CREATE TABLE `ax_unit_okei`
(
    `id`                   bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `code`                 varchar(10)         NOT NULL,
    `title`                varchar(255)        NOT NULL,
    `national_symbol`      varchar(45)      DEFAULT NULL,
    `national_code`        varchar(45)      DEFAULT NULL,
    `international_symbol` varchar(45)      DEFAULT NULL,
    `international_code`   varchar(45)      DEFAULT NULL,
    `description`          varchar(255)     DEFAULT NULL,
    `sort`                 int(11)          DEFAULT NULL,
    `image`                varchar(255)     DEFAULT NULL,
    `created_at`           int(11) unsigned DEFAULT NULL,
    `updated_at`           int(11) unsigned DEFAULT NULL,
    `deleted_at`           int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    UNIQUE KEY `code_UNIQUE` (`code`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO `ax_unit_okei` (`id`, `code`, `title`, `national_symbol`, `national_code`, `international_symbol`,
                            `international_code`, `description`, `sort`, `image`, `created_at`, `updated_at`,
                            `deleted_at`)
VALUES (1, '003', 'Миллиметр', 'мм', 'mm', 'ММ', 'MMT', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (2, '004', 'Сантиметр', 'см', 'cm', 'СМ', 'CMT', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (3, '005', 'Дециметр', 'дм', 'dm', 'ДМ', 'DMT', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (4, '006', 'Метр', 'м', 'm', 'М', 'MTR', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (5, '008', 'Километр; тысяча метров', 'км; 10^3 м', 'km', 'КМ; ТЫС М', 'KMT', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (6, '009', 'Мегаметр; миллион метров', 'Мм; 10^6 м', 'Mm', 'МЕГАМ; МЛН М', 'MAM', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (7, '039', 'Дюйм (25,4 мм)', 'дюйм', 'in', 'ДЮЙМ', 'INH', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (8, '041', 'Фут (0,3048 м)', 'фут', 'ft', 'ФУТ', 'FOT', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (9, '043', 'Ярд (0,9144 м)', 'ярд', 'yd', 'ЯРД', 'YRD', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (10, '047', 'Морская миля (1852 м)', 'миля', 'n mile', 'МИЛЬ', 'NMI', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (11, '050', 'Квадратный миллиметр', 'мм^2', 'mm^2', 'ММ2', 'MMK', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (12, '051', 'Квадратный сантиметр', 'см^2', 'cm^2', 'СМ2', 'CMK', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (13, '053', 'Квадратный дециметр', 'дм^2', 'dm^2', 'ДМ2', 'DMK', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (14, '055', 'Квадратный метр', 'м^2', 'm^2', 'М2', 'MTK', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (15, '058', 'Тысяча квадратных метров', '10^3 м^2', 'daa', 'ТЫС М2', 'DAA', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (16, '059', 'Гектар', 'га', 'ha', 'ГА', 'HAR', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (17, '061', 'Квадратный километр', 'км^2', 'km^2', 'КМ2', 'KMK', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (18, '071', 'Квадратный дюйм (645,16 мм^2)', 'дюйм^2', 'in^2', 'ДЮЙМ2', 'INK', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (19, '073', 'Квадратный фут (0,092903 м^2)', 'фут^2', 'ft^2', 'ФУТ2', 'FTK', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (20, '075', 'Квадратный ярд (0,8361274 м^2)', 'ярд^2', 'yd^2', 'ЯРД2', 'YDK', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (21, '109', 'Ар (100 м^2)', 'а', 'a', 'АР', 'ARE', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (22, '110', 'Кубический миллиметр', 'мм^3', 'mm^3', 'ММ3', 'MMQ', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (23, '111', 'Кубический сантиметр; миллилитр', 'см^3; мл', 'cm^3; ml', 'СМ3; МЛ', 'CMQ; MLT', NULL, NULL, NULL,
        1651608269, 1651608269, NULL),
       (24, '112', 'Литр; кубический дециметр', 'л; дм^3', 'I; L; dm^3', 'Л; ДМ3', 'LTR; DMQ', NULL, NULL, NULL,
        1651608269, 1651608269, NULL),
       (25, '113', 'Кубический метр', 'м^3', 'm^3', 'М3', 'MTQ', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (26, '118', 'Децилитр', 'дл', 'dl', 'ДЛ', 'DLT', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (27, '122', 'Гектолитр', 'гл', 'hl', 'ГЛ', 'HLT', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (28, '126', 'Мегалитр', 'Мл', 'Ml', 'МЕГАЛ', 'MAL', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (29, '131', 'Кубический дюйм (16387,1 мм^3)', 'дюйм^3', 'in^3', 'ДЮЙМ3', 'INQ', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (30, '132', 'Кубический фут (0,02831685 м^3)', 'фут^3', 'ft^3', 'ФУТ3', 'FTQ', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (31, '133', 'Кубический ярд (0,764555 м^3)', 'ярд^3', 'yd^3', 'ЯРД3', 'YDQ', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (32, '159', 'Миллион кубических метров', '10^6 м^3', '10^6 m^3', 'МЛН М3', 'HMQ', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (33, '160', 'Гектограмм', 'гг', 'hg', 'ГГ', 'HGM', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (34, '161', 'Миллиграмм', 'мг', 'mg', 'МГ', 'MGM', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (35, '162', 'Метрический карат', 'кар', 'МС', 'КАР', 'CTM', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (36, '163', 'Грамм', 'г', 'g', 'Г', 'GRM', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (37, '166', 'Килограмм', 'кг', 'kg', 'КГ', 'KGM', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (38, '168', 'Тонна; метрическая тонна (1000 кг)', 'т', 't', 'Т', 'TNE', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (39, '170', 'Килотонна', '10^3 т', 'kt', 'КТ', 'KTN', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (40, '173', 'Сантиграмм', 'сг', 'cg', 'СГ', 'CGM', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (41, '181', 'Брутто-регистровая тонна (2,8316 м^3)', 'БРТ', '-', 'БРУТТ. РЕГИСТР Т', 'GRT', NULL, NULL, NULL,
        1651608269, 1651608269, NULL),
       (42, '185', 'Грузоподъемность в метрических тоннах', 'т грп', '-', 'Т ГРУЗОПОД', 'CCT', NULL, NULL, NULL,
        1651608269, 1651608269, NULL),
       (43, '206', 'Центнер (метрический) (100 кг); гектокилограмм; квинтал (метрический); децитонна', 'ц',
        'q; 10^2 kg', 'Ц', 'DTN', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (44, '212', 'Ватт', 'Вт', 'W', 'ВТ', 'WTT', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (45, '214', 'Киловатт', 'кВт', 'kW', 'КВТ', 'KWT', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (46, '215', 'Мегаватт; тысяча киловатт', 'МВт; 10^3 кВт', 'MW', 'МЕГАВТ; ТЫС КВТ', 'MAW', NULL, NULL, NULL,
        1651608269, 1651608269, NULL),
       (47, '222', 'Вольт', 'В', 'V', 'В', 'VLT', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (48, '223', 'Киловольт', 'кВ', 'kV', 'КВ', 'KVT', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (49, '227', 'Киловольт-ампер', 'кВ.А', 'kV.A', 'КВ.А', 'KVA', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (50, '228', 'Мегавольт-ампер (тысяча киловольт-ампер)', 'МВ.А', 'MV.A', 'МЕГАВ.А', 'MVA', NULL, NULL, NULL,
        1651608269, 1651608269, NULL),
       (51, '230', 'Киловар', 'квар', 'kVAR', 'КВАР', 'KVR', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (52, '243', 'Ватт-час', 'Вт.ч', 'W.h', 'ВТ.Ч', 'WHR', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (53, '245', 'Киловатт-час', 'кВт.ч', 'kW.h', 'КВТ.Ч', 'KWH', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (54, '246', 'Мегаватт-час; 1000 киловатт-часов', 'МВт.ч; 10^3 кВт.ч', 'МW.h', 'МЕГАВТ.Ч; ТЫС КВТ.Ч', 'MWH', NULL,
        NULL, NULL, 1651608269, 1651608269, NULL),
       (55, '247', 'Гигаватт-час (миллион киловатт-часов)', 'ГВт.ч', 'GW.h', 'ГИГАВТ.Ч', 'GWH', NULL, NULL, NULL,
        1651608269, 1651608269, NULL),
       (56, '260', 'Ампер', 'А', 'A', 'А', 'AMP', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (57, '263', 'Ампер-час (3,6 кКл)', 'А.ч', 'A.h', 'А.Ч', 'AMH', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (58, '264', 'Тысяча ампер-часов', '10^3 А.ч', '10^3 A.h', 'ТЫС А.Ч', 'TAH', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (59, '270', 'Кулон', 'Кл', 'C', 'КЛ', 'COU', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (60, '271', 'Джоуль', 'Дж', 'J', 'ДЖ', 'JOU', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (61, '273', 'Килоджоуль', 'кДж', 'kJ', 'КДЖ', 'KJO', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (62, '274', 'Ом', 'Ом', 'Ω', 'ОМ', 'OHM', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (63, '280', 'Градус Цельсия', '°C', '°C', 'ГРАД ЦЕЛЬС', 'CEL', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (64, '281', 'Градус Фаренгейта', '°F', '°F', 'ГРАД ФАРЕНГ', 'FAN', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (65, '282', 'Кандела', 'кд', 'cd', 'КД', 'CDL', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (66, '283', 'Люкс', 'лк', 'lx', 'ЛК', 'LUX', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (67, '284', 'Люмен', 'лм', 'lm', 'ЛМ', 'LUM', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (68, '288', 'Кельвин', 'K', 'K', 'К', 'KEL', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (69, '289', 'Ньютон', 'Н', 'N', 'Н', 'NEW', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (70, '290', 'Герц', 'Гц', 'Hz', 'ГЦ', 'HTZ', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (71, '291', 'Килогерц', 'кГц', 'kHz', 'КГЦ', 'KHZ', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (72, '292', 'Мегагерц', 'МГц', 'MHz', 'МЕГАГЦ', 'MHZ', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (73, '294', 'Паскаль', 'Па', 'Pa', 'ПА', 'PAL', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (74, '296', 'Сименс', 'См', 'S', 'СИ', 'SIE', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (75, '297', 'Килопаскаль', 'кПа', 'kPa', 'КПА', 'KPA', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (76, '298', 'Мегапаскаль', 'МПа', 'MPa', 'МЕГАПА', 'MPA', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (77, '300', 'Физическая атмосфера (101325 Па)', 'атм', 'atm', 'АТМ', 'ATM', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (78, '301', 'Техническая атмосфера (98066,5 Па)', 'ат', 'at', 'АТТ', 'ATT', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (79, '302', 'Гигабеккерель', 'ГБк', 'GBq', 'ГИГАБК', 'GBQ', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (80, '304', 'Милликюри', 'мКи', 'mCi', 'МКИ', 'MCU', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (81, '305', 'Кюри', 'Ки', 'Ci', 'КИ', 'CUR', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (82, '306', 'Грамм делящихся изотопов', 'г Д/И', 'g fissile isotopes', 'Г ДЕЛЯЩ ИЗОТОП', 'GFI', NULL, NULL, NULL,
        1651608269, 1651608269, NULL),
       (83, '308', 'Миллибар', 'мб', 'mbar', 'МБАР', 'MBR', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (84, '309', 'Бар', 'бар', 'bar', 'БАР', 'BAR', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (85, '310', 'Гектобар', 'гб', 'hbar', 'ГБАР', 'HBA', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (86, '312', 'Килобар', 'кб', 'kbar', 'КБАР', 'KBA', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (87, '314', 'Фарад', 'Ф', 'F', 'Ф', 'FAR', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (88, '316', 'Килограмм на кубический метр', 'кг/м^3', 'kg/m^3', 'КГ/М3', 'KMQ', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (89, '323', 'Беккерель', 'Бк', 'Bq', 'БК', 'BQL', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (90, '324', 'Вебер', 'Вб', 'Wb', 'ВБ', 'WEB', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (91, '327', 'Узел (миля/ч)', 'уз', 'kn', 'УЗ', 'KNT', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (92, '328', 'Метр в секунду', 'м/с', 'm/s', 'М/С', 'MTS', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (93, '330', 'Оборот в секунду', 'об/с', 'r/s', 'ОБ/С', 'RPS', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (94, '331', 'Оборот в минуту', 'об/мин', 'r/min', 'ОБ/МИН', 'RPM', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (95, '333', 'Километр в час', 'км/ч', 'km/h', 'КМ/Ч', 'KMH', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (96, '335', 'Метр на секунду в квадрате', 'м/с^2', 'm/s^2', 'М/С2', 'MSK', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (97, '349', 'Кулон на килограмм', 'Кл/кг', 'C/kg', 'КЛ/КГ', 'CKG', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (98, '354', 'Секунда', 'с', 's', 'С', 'SEC', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (99, '355', 'Минута', 'мин', 'min', 'МИН', 'MIN', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (100, '356', 'Час', 'ч', 'h', 'Ч', 'HUR', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (101, '359', 'Сутки', 'сут; дн', 'd', 'СУТ; ДН', 'DAY', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (102, '360', 'Неделя', 'нед', '-', 'НЕД', 'WEE', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (103, '361', 'Декада', 'дек', '-', 'ДЕК', 'DAD', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (104, '362', 'Месяц', 'мес', '-', 'МЕС', 'MON', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (105, '364', 'Квартал', 'кварт', '-', 'КВАРТ', 'QAN', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (106, '365', 'Полугодие', 'полгода', '-', 'ПОЛГОД', 'SAN', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (107, '366', 'Год', 'г; лет', 'a', 'ГОД; ЛЕТ', 'ANN', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (108, '368', 'Десятилетие', 'деслет', '-', 'ДЕСЛЕТ', 'DEC', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (109, '499', 'Килограмм в секунду', 'кг/с', '-', 'КГ/С', 'KGS', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (110, '533', 'Тонна пара в час', 'т пар/ч', '-', 'Т ПАР/Ч', 'TSH', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (111, '596', 'Кубический метр в секунду', 'м^3/с', 'm^3/s', 'М3/С', 'MQS', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (112, '598', 'Кубический метр в час', 'м^3/ч', 'm^3/h', 'М3/Ч', 'MQH', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (113, '599', 'Тысяча кубических метров в сутки', '10^3 м^3/сут', '-', 'ТЫС М3/СУТ', 'TQD', NULL, NULL, NULL,
        1651608269, 1651608269, NULL),
       (114, '616', 'Бобина', 'боб', '-', 'БОБ', 'NBB', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (115, '625', 'Лист', 'л.', '-', 'ЛИСТ', 'LEF', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (116, '626', 'Сто листов', '100 л.', '-', '100 ЛИСТ', 'CLF', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (117, '630', 'Тысяча стандартных условных кирпичей', 'тыс станд. усл. кирп', '-', 'ТЫС СТАНД УСЛ КИРП', 'MBE',
        NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (118, '641', 'Дюжина (12 шт.)', 'дюжина', 'Doz; 12', 'ДЮЖИНА', 'DZN', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (119, '657', 'Изделие', 'изд', '-', 'ИЗД', 'NAR', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (120, '683', 'Сто ящиков', '100 ящ.', 'Hbx', '100 ЯЩ', 'HBX', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (121, '704', 'Набор', 'набор', '-', 'НАБОР', 'SET', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (122, '715', 'Пара (2 шт.)', 'пар', 'pr; 2', 'ПАР', 'NPR', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (123, '730', 'Два десятка', '20', '20', '2 ДЕС', 'SCO', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (124, '732', 'Десять пар', '10 пар', '-', 'ДЕС ПАР', 'TPR', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (125, '733', 'Дюжина пар', 'дюжина пар', '-', 'ДЮЖИНА ПАР', 'DPR', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (126, '734', 'Посылка', 'посыл', '-', 'ПОСЫЛ', 'NPL', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (127, '735', 'Часть', 'часть', '-', 'ЧАСТЬ', 'NPT', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (128, '736', 'Рулон', 'рул', '-', 'РУЛ', 'NPL', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (129, '737', 'Дюжина рулонов', 'дюжина рул', '-', 'ДЮЖИНА РУЛ', 'DRL', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (130, '740', 'Дюжина штук', 'дюжина шт', '-', 'ДЮЖИНА ШТ', 'DPC', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (131, '745', 'Элемент', 'элем', 'CI', 'ЭЛЕМ', 'NCL', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (132, '778', 'Упаковка', 'упак', '-', 'УПАК', 'NMP', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (133, '780', 'Дюжина упаковок', 'дюжина упак', '-', 'ДЮЖИНА УПАК', 'DZP', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (134, '781', 'Сто упаковок', '100 упак', '-', '100 УПАК', 'CNP', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (135, '796', 'Штука', 'шт', 'pc; 1', 'ШТ', 'PCE; NMB', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (136, '797', 'Сто штук', '100 шт', '100', '100 ШТ', 'CEN', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (137, '798', 'Тысяча штук', 'тыс. шт; 1000 шт', '1000', 'ТЫС ШТ', 'MIL', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (138, '799', 'Миллион штук', '10^6 шт', '10^6', 'МЛН ШТ', 'MIO', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (139, '800', 'Миллиард штук', '10^9 шт', '10^9', 'МЛРД ШТ', 'MLD', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (140, '801', 'Биллион штук (Европа); триллион штук', '10^12 шт', '10^12', 'БИЛЛ ШТ (ЕВР); ТРИЛЛ ШТ', 'BIL', NULL,
        NULL, NULL, 1651608269, 1651608269, NULL),
       (141, '802', 'Квинтильон штук (Европа)', '10^18 шт', '10^18', 'КВИНТ ШТ', 'TRL', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (142, '820', 'Крепость спирта по массе', 'креп. спирта по массе', '% mds', 'КРЕП СПИРТ ПО МАССЕ', 'ASM', NULL,
        NULL, NULL, 1651608269, 1651608269, NULL),
       (143, '821', 'Крепость спирта по объему', 'креп. спирта по объему', '% vol', 'КРЕП СПИРТ ПО ОБЪЕМ', 'ASV', NULL,
        NULL, NULL, 1651608269, 1651608269, NULL),
       (144, '831', 'Литр чистого (100%) спирта', 'л 100% спирта', '-', 'Л ЧИСТ СПИРТ', 'LPA', NULL, NULL, NULL,
        1651608269, 1651608269, NULL),
       (145, '833', 'Гектолитр чистого (100%) спирта', 'Гл 100% спирта', '-', 'ГЛ ЧИСТ СПИРТ', 'HPA', NULL, NULL, NULL,
        1651608269, 1651608269, NULL),
       (146, '841', 'Килограмм пероксида водорода', 'кг H^^2О^^2', '-', 'КГ ПЕРОКСИД ВОДОРОДА', '-', NULL, NULL, NULL,
        1651608269, 1651608269, NULL),
       (147, '845', 'Килограмм 90%-го сухого вещества', 'кг 90% с/в', '-', 'КГ 90 ПРОЦ СУХ ВЕЩ', 'KSD', NULL, NULL,
        NULL, 1651608269, 1651608269, NULL),
       (148, '847', 'Тонна 90%-го сухого вещества', 'т 90% с/в', '-', 'Т 90 ПРОЦ СУХ ВЕЩ', 'TSD', NULL, NULL, NULL,
        1651608269, 1651608269, NULL),
       (149, '852', 'Килограмм оксида калия', 'кг К^^2О', '-', 'КГ ОКСИД КАЛИЯ', 'KPO', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (150, '859', 'Килограмм гидроксида калия', 'кг КОН', '-', 'КГ ГИДРОКСИД КАЛИЯ', 'KPH', NULL, NULL, NULL,
        1651608269, 1651608269, NULL),
       (151, '861', 'Килограмм азота', 'кг N', '-', 'КГ АЗОТ', 'KNI', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (152, '863', 'Килограмм гидроксида натрия', 'кг NaOH', '-', 'КГ ГИДРОКСИД НАТРИЯ', 'KSH', NULL, NULL, NULL,
        1651608269, 1651608269, NULL),
       (153, '865', 'Килограмм пятиокиси фосфора', 'кг Р^^2О^^5', '-', 'КГ ПЯТИОКИСЬ ФОСФОРА', 'KPP', NULL, NULL, NULL,
        1651608269, 1651608269, NULL),
       (154, '867', 'Килограмм урана', 'кг U', '-', 'КГ УРАН', 'KUR', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (155, '018', 'Погонный метр', 'пог. м', '', 'ПОГ М', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (156, '019', 'Тысяча погонных метров', '10^3 пог. м', '', 'ТЫС ПОГ М', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (157, '020', 'Условный метр', 'усл. м', '', 'УСЛ М', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (158, '048', 'Тысяча условных метров', '10^3 усл. м', '', 'ТЫС УСЛ М', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (159, '049', 'Километр условных труб', 'км усл. труб', '', 'КМ УСЛ ТРУБ', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (160, '054', 'Тысяча квадратных дециметров', '10^3 дм^2', '', 'ТЫС ДМ2', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (161, '056', 'Миллион квадратных дециметров', '10^6 дм^2', '', 'МЛН ДМ2', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (162, '057', 'Миллион квадратных метров', '10^6 м^2', '', 'МЛН М2', '', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (163, '060', 'Тысяча гектаров', '10^3 га', '', 'ТЫС ГА', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (164, '062', 'Условный квадратный метр', 'усл. м^2', '', 'УСЛ М2', '', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (165, '063', 'Тысяча условных квадратных метров', '10^3 усл. м^2', '', 'ТЫС УСЛ М2', '', NULL, NULL, NULL,
        1651608269, 1651608269, NULL),
       (166, '064', 'Миллион условных квадратных метров', '10^6 усл. м^2', '', 'МЛН УСЛ М2', '', NULL, NULL, NULL,
        1651608269, 1651608269, NULL),
       (167, '081', 'Квадратный метр общей площади', 'м^2 общ. пл', '', 'М2 ОБЩ ПЛ', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (168, '082', 'Тысяча квадратных метров общей площади', '10^3 м^2 общ. пл', '', 'ТЫС М2 ОБЩ ПЛ', '', NULL, NULL,
        NULL, 1651608269, 1651608269, NULL),
       (169, '083', 'Миллион квадратных метров общей площади', '10^6 м^2 общ. пл', '', 'МЛН М2. ОБЩ ПЛ', '', NULL, NULL,
        NULL, 1651608269, 1651608269, NULL),
       (170, '084', 'Квадратный метр жилой площади', 'м^2 жил. пл', '', 'М2 ЖИЛ ПЛ', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (171, '085', 'Тысяча квадратных метров жилой площади', '10^3 м^2 жил. пл', '', 'ТЫС М2 ЖИЛ ПЛ', '', NULL, NULL,
        NULL, 1651608269, 1651608269, NULL),
       (172, '086', 'Миллион квадратных метров жилой площади', '10^6 м^2 жил. пл', '', 'МЛН М2 ЖИЛ ПЛ', '', NULL, NULL,
        NULL, 1651608269, 1651608269, NULL),
       (173, '087', 'Квадратный метр учебно-лабораторных зданий', 'м^2 уч. лаб. здан', '', 'М2 УЧ.ЛАБ ЗДАН', '', NULL,
        NULL, NULL, 1651608269, 1651608269, NULL),
       (174, '088', 'Тысяча квадратных метров учебно-лабораторных зданий', '10^3 м^2 уч. лаб. здан', '',
        'ТЫС М2 УЧ. ЛАБ ЗДАН', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (175, '089', 'Миллион квадратных метров в двухмиллиметровом исчислении', '10^6 м^2 2 мм исч', '',
        'МЛН М2 2ММ ИСЧ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (176, '114', 'Тысяча кубических метров', '10^3 м^3', '', 'ТЫС М3', '', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (177, '115', 'Миллиард кубических метров', '10^9 м^3', '', 'МЛРД М3', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (178, '116', 'Декалитр', 'дкл', '', 'ДКЛ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (179, '119', 'Тысяча декалитров', '10^3 дкл', '', 'ТЫС ДКЛ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (180, '120', 'Миллион декалитров', '10^6 дкл', '', 'МЛН ДКЛ', '', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (181, '121', 'Плотный кубический метр', 'плотн. м^3', '', 'ПЛОТН М3', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (182, '123', 'Условный кубический метр', 'усл. м^3', '', 'УСЛ М3', '', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (183, '124', 'Тысяча условных кубических метров', '10^3 усл. м^3', '', 'ТЫС УСЛ М3', '', NULL, NULL, NULL,
        1651608269, 1651608269, NULL),
       (184, '125', 'Миллион кубических метров переработки газа', '10^6 м^3 перераб. газа', '', 'МЛН М3 ПЕРЕРАБ ГАЗА',
        '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (185, '127', 'Тысяча плотных кубических метров', '10^3 плотн. м^3', '', 'ТЫС ПЛОТН М3', '', NULL, NULL, NULL,
        1651608269, 1651608269, NULL),
       (186, '128', 'Тысяча полулитров', '10^3 пол. л', '', 'ТЫС ПОЛ Л', '', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (187, '129', 'Миллион полулитров', '10^6 пол. л', '', 'МЛН ПОЛ Л', '', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (188, '130', 'Тысяча литров; 1000 литров', '10^3 л; 1000 л', '', 'ТЫС Л', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (189, '165', 'Тысяча каратов метрических', '10^3 кар', '', 'ТЫС КАР', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (190, '167', 'Миллион каратов метрических', '10^6 кар', '', 'МЛН КАР', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (191, '169', 'Тысяча тонн', '10^3 т', '', 'ТЫС Т', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (192, '171', 'Миллион тонн', '10^6 т', '', 'МЛН Т', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (193, '172', 'Тонна условного топлива', 'т усл. топл', '', 'Т УСЛ ТОПЛ', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (194, '175', 'Тысяча тонн условного топлива', '10^3 т усл. топл', '', 'ТЫС Т УСЛ ТОПЛ', '', NULL, NULL, NULL,
        1651608269, 1651608269, NULL),
       (195, '176', 'Миллион тонн условного топлива', '10^6 т усл. топл', '', 'МЛН Т УСЛ ТОПЛ', '', NULL, NULL, NULL,
        1651608269, 1651608269, NULL),
       (196, '177', 'Тысяча тонн единовременного хранения', '10^3 т единовр. хран', '', 'ТЫС Т ЕДИНОВР ХРАН', '', NULL,
        NULL, NULL, 1651608269, 1651608269, NULL),
       (197, '178', 'Тысяча тонн переработки', '10^3 т перераб', '', 'ТЫС Т ПЕРЕРАБ', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (198, '179', 'Условная тонна', 'усл. т', '', 'УСЛ Т', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (199, '207', 'Тысяча центнеров', '10^3 ц', '', 'ТЫС Ц', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (200, '226', 'Вольт-ампер', 'В.А', '', 'В.А', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (201, '231', 'Метр в час', 'м/ч', '', 'М/Ч', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (202, '232', 'Килокалория', 'ккал', '', 'ККАЛ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (203, '233', 'Гигакалория', 'Гкал', '', 'ГИГАКАЛ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (204, '234', 'Тысяча гигакалорий', '10^3 Гкал', '', 'ТЫС ГИГАКАЛ', '', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (205, '235', 'Миллион гигакалорий', '10^6 Гкал', '', 'МЛН ГИГАКАЛ', '', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (206, '236', 'Калория в час', 'кал/ч', '', 'КАЛ/Ч', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (207, '237', 'Килокалория в час', 'ккал/ч', '', 'ККАЛ/Ч', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (208, '238', 'Гигакалория в час', 'Гкал/ч', '', 'ГИГАКАЛ/Ч', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (209, '239', 'Тысяча гигакалорий в час', '10^3 Гкал/ч', '', 'ТЫС ГИГАКАЛ/Ч', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (210, '241', 'Миллион ампер-часов', '10^6 А.ч', '', 'МЛН А.Ч', '', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (211, '242', 'Миллион киловольт-ампер', '10^6 кВ.А', '', 'МЛН КВ.А', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (212, '248', 'Киловольт-ампер реактивный', 'кВ.А Р', '', 'КВ.А Р', '', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (213, '249', 'Миллиард киловатт-часов', '10^9 кВт.ч', '', 'МЛРД КВТ.Ч', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (214, '250', 'Тысяча киловольт-ампер реактивных', '10^3 кВ.А Р', '', 'ТЫС КВ.А Р', '', NULL, NULL, NULL,
        1651608269, 1651608269, NULL),
       (215, '251', 'Лошадиная сила', 'л. с', '', 'ЛС', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (216, '252', 'Тысяча лошадиных сил', '10^3 л. с', '', 'ТЫС ЛС', '', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (217, '253', 'Миллион лошадиных сил', '10^6 л. с', '', 'МЛН ЛС', '', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (218, '254', 'Бит', 'бит', '', 'БИТ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (219, '255', 'Байт', 'байт', '', 'БАЙТ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (220, '256', 'Килобайт', 'кбайт', '', 'КБАЙТ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (221, '257', 'Мегабайт', 'Мбайт', '', 'МБАЙТ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (222, '258', 'Бод', 'бод', '', 'БОД', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (223, '287', 'Генри', 'Гн', '', 'ГН', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (224, '313', 'Тесла', 'Тл', '', 'ТЛ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (225, '317', 'Килограмм на квадратный сантиметр', 'кг/см^2', '', 'КГ/СМ2', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (226, '337', 'Миллиметр водяного столба', 'мм вод. ст', '', 'ММ ВОД СТ', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (227, '338', 'Миллиметр ртутного столба', 'мм рт. ст', '', 'ММ РТ СТ', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (228, '339', 'Сантиметр водяного столба', 'см вод. ст', '', 'СМ ВОД СТ', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (229, '352', 'Микросекунда', 'мкс', '', 'МКС', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (230, '353', 'Миллисекунда', 'млс', '', 'МЛС', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (231, '383', 'Рубль', 'руб', '', 'РУБ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (232, '384', 'Тысяча рублей', '10^3 руб', '', 'ТЫС РУБ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (233, '385', 'Миллион рублей', '10^6 руб', '', 'МЛН РУБ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (234, '386', 'Миллиард рублей', '10^9 руб', '', 'МЛРД РУБ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (235, '387', 'Триллион рублей', '10^12 руб', '', 'ТРИЛЛ РУБ', '', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (236, '388', 'Квадрильон рублей', '10^15 руб', '', 'КВАДР РУБ', '', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (237, '414', 'Пассажиро-километр', 'пасс.км', '', 'ПАСС.КМ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (238, '421', 'Пассажирское место (пассажирских мест)', 'пасс. мест', '', 'ПАСС МЕСТ', '', NULL, NULL, NULL,
        1651608269, 1651608269, NULL),
       (239, '423', 'Тысяча пассажиро-километров', '10^3 пасс.км', '', 'ТЫС ПАСС.КМ', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (240, '424', 'Миллион пассажиро-километров', '10^6 пасс. км', '', 'МЛН ПАСС.КМ', '', NULL, NULL, NULL,
        1651608269, 1651608269, NULL),
       (241, '427', 'Пассажиропоток', 'пасс.поток', '', 'ПАСС.ПОТОК', '', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (242, '449', 'Тонно-километр', 'т.км', '', 'Т.КМ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (243, '450', 'Тысяча тонно-километров', '10^3 т.км', '', 'ТЫС Т.КМ', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (244, '451', 'Миллион тонно-километров', '10^6 т. км', '', 'МЛН Т.КМ', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (245, '479', 'Тысяча наборов', '10^3 набор', '', 'ТЫС НАБОР', '', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (246, '510', 'Грамм на киловатт-час', 'г/кВт.ч', '', 'Г/КВТ.Ч', '', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (247, '511', 'Килограмм на гигакалорию', 'кг/Гкал', '', 'КГ/ГИГАКАЛ', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (248, '512', 'Тонно-номер', 'т.ном', '', 'Т.НОМ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (249, '513', 'Автотонна', 'авто т', '', 'АВТО Т', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (250, '514', 'Тонна тяги', 'т.тяги', '', 'Т ТЯГИ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (251, '515', 'Дедвейт-тонна', 'дедвейт.т', '', 'ДЕДВЕЙТ.Т', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (252, '516', 'Тонно-танид', 'т.танид', '', 'Т.ТАНИД', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (253, '521', 'Человек на квадратный метр', 'чел/м^2', '', 'ЧЕЛ/М2', '', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (254, '522', 'Человек на квадратный километр', 'чел/км^2', '', 'ЧЕЛ/КМ2', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (255, '534', 'Тонна в час', 'т/ч', '', 'Т/Ч', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (256, '535', 'Тонна в сутки', 'т/сут', '', 'Т/СУТ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (257, '536', 'Тонна в смену', 'т/смен', '', 'Т/СМЕН', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (258, '537', 'Тысяча тонн в сезон', '10^3 т/сез', '', 'ТЫС Т/СЕЗ', '', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (259, '538', 'Тысяча тонн в год', '10^3 т/год', '', 'ТЫС Т/ГОД', '', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (260, '539', 'Человеко-час', 'чел.ч', '', 'ЧЕЛ.Ч', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (261, '540', 'Человеко-день', 'чел.дн', '', 'ЧЕЛ.ДН', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (262, '541', 'Тысяча человеко-дней', '10^3 чел.дн', '', 'ТЫС ЧЕЛ.ДН', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (263, '542', 'Тысяча человеко-часов', '10^3 чел.ч', '', 'ТЫС ЧЕЛ.Ч', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (264, '543', 'Тысяча условных банок в смену', '10^3 усл. банк/ смен', '', 'ТЫС УСЛ БАНК/СМЕН', '', NULL, NULL,
        NULL, 1651608269, 1651608269, NULL),
       (265, '544', 'Миллион единиц в год', '10^6 ед/год', '', 'МЛН ЕД/ГОД', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (266, '545', 'Посещение в смену', 'посещ/смен', '', 'ПОСЕЩ/СМЕН', '', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (267, '546', 'Тысяча посещений в смену', '10^3 посещ/смен', '', 'ТЫС ПОСЕЩ/ СМЕН', '', NULL, NULL, NULL,
        1651608269, 1651608269, NULL),
       (268, '547', 'Пара в смену', 'пар/смен', '', 'ПАР/СМЕН', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (269, '548', 'Тысяча пар в смену', '10^3 пар/смен', '', 'ТЫС ПАР/СМЕН', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (270, '550', 'Миллион тонн в год', '10^6 т/год', '', 'МЛН Т/ГОД', '', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (271, '552', 'Тонна переработки в сутки', 'т перераб/сут', '', 'Т ПЕРЕРАБ/СУТ', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (272, '553', 'Тысяча тонн переработки в сутки', '10^3 т перераб/ сут', '', 'ТЫС Т ПЕРЕРАБ/СУТ', '', NULL, NULL,
        NULL, 1651608269, 1651608269, NULL),
       (273, '554', 'Центнер переработки в сутки', 'ц перераб/сут', '', 'Ц ПЕРЕРАБ/СУТ', '', NULL, NULL, NULL,
        1651608269, 1651608269, NULL),
       (274, '555', 'Тысяча центнеров переработки в сутки', '10^3 ц перераб/ сут', '', 'ТЫС Ц ПЕРЕРАБ/СУТ', '', NULL,
        NULL, NULL, 1651608269, 1651608269, NULL),
       (275, '556', 'Тысяча голов в год', '10^3 гол/год', '', 'ТЫС ГОЛ/ГОД', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (276, '557', 'Миллион голов в год', '10^6 гол/год', '', 'МЛН ГОЛ/ГОД', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (277, '558', 'Тысяча птицемест', '10^3 птицемест', '', 'ТЫС ПТИЦЕМЕСТ', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (278, '559', 'Тысяча кур-несушек', '10^3 кур. несуш', '', 'ТЫС КУР. НЕСУШ', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (279, '2541', 'Бит в секунду', 'бит/с', '', 'БИТ/С', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (280, '2543', 'Килобит в секунду', 'кбит/с', '', 'КБИТ/С', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (281, '561', 'Тысяча тонн пара в час', '10^3 т пар/ч', '', 'ТЫС Т ПАР/Ч', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (282, '562', 'Тысяча прядильных веретен', '10^3 пряд.верет', '', 'ТЫС ПРЯД ВЕРЕТ', '', NULL, NULL, NULL,
        1651608269, 1651608269, NULL),
       (283, '563', 'Тысяча прядильных мест', '10^3 пряд.мест', '', 'ТЫС ПРЯД МЕСТ', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (284, '639', 'Доза', 'доз', '', 'ДОЗ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (285, '640', 'Тысяча доз', '10^3 доз', '', 'ТЫС ДОЗ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (286, '642', 'Единица', 'ед', '', 'ЕД', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (287, '643', 'Тысяча единиц', '10^3 ед', '', 'ТЫС ЕД', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (288, '644', 'Миллион единиц', '10^6 ед', '', 'МЛН ЕД', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (289, '661', 'Канал', 'канал', '', 'КАНАЛ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (290, '673', 'Тысяча комплектов', '10^3 компл', '', 'ТЫС КОМПЛ', '', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (291, '698', 'Место', 'мест', '', 'МЕСТ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (292, '699', 'Тысяча мест', '10^3 мест', '', 'ТЫС МЕСТ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (293, '709', 'Тысяча номеров', '10^3 ном', '', 'ТЫС НОМ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (294, '724', 'Тысяча гектаров порций', '10^3 га порц', '', 'ТЫС ГА ПОРЦ', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (295, '729', 'Тысяча пачек', '10^3 пач', '', 'ТЫС ПАЧ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (296, '744', 'Процент', '%', '', 'ПРОЦ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (297, '746', 'Промилле (0,1 процента)', '‰', '', 'ПРОМИЛЛЕ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (298, '751', 'Тысяча рулонов', '10^3 рул', '', 'ТЫС РУЛ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (299, '761', 'Тысяча станов', '10^3 стан', '', 'ТЫС СТАН', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (300, '762', 'Станция', 'станц', '', 'СТАНЦ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (301, '775', 'Тысяча тюбиков', '10^3 тюбик', '', 'ТЫС ТЮБИК', '', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (302, '776', 'Тысяча условных тубов', '10^3 усл.туб', '', 'ТЫС УСЛ ТУБ', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (303, '779', 'Миллион упаковок', '10^6 упак', '', 'МЛН УПАК', '', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (304, '782', 'Тысяча упаковок', '10^3 упак', '', 'ТЫС УПАК', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (305, '792', 'Человек', 'чел', '', 'ЧЕЛ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (306, '793', 'Тысяча человек', '10^3 чел', '', 'ТЫС ЧЕЛ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (307, '794', 'Миллион человек', '10^6 чел', '', 'МЛН ЧЕЛ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (308, '808', 'Миллион экземпляров', '10^6 экз', '', 'МЛН ЭКЗ', '', NULL, NULL, NULL, 1651608269, 1651608269,
        NULL),
       (309, '810', 'Ячейка', 'яч', '', 'ЯЧ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (310, '812', 'Ящик', 'ящ', '', 'ЯЩ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (311, '836', 'Голова', 'гол', '', 'ГОЛ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (312, '837', 'Тысяча пар', '10^3 пар', '', 'ТЫС ПАР', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (313, '838', 'Миллион пар', '10^6 пар', '', 'МЛН ПАР', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (314, '839', 'Комплект', 'компл', '', 'КОМПЛ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (315, '840', 'Секция', 'секц', '', 'СЕКЦ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (316, '868', 'Бутылка', 'бут', '', 'БУТ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (317, '869', 'Тысяча бутылок', '10^3 бут', '', 'ТЫС БУТ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (318, '870', 'Ампула', 'ампул', '', 'АМПУЛ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (319, '871', 'Тысяча ампул', '10^3 ампул', '', 'ТЫС АМПУЛ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (320, '872', 'Флакон', 'флак', '', 'ФЛАК', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (321, '873', 'Тысяча флаконов', '10^3 флак', '', 'ТЫС ФЛАК', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (322, '874', 'Тысяча тубов', '10^3 туб', '', 'ТЫС ТУБ', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (323, '875', 'Тысяча коробок', '10^3 кор', '', 'ТЫС КОР', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (324, '876', 'Условная единица', 'усл. ед', '', 'УСЛ ЕД', '', NULL, NULL, NULL, 1651608269, 1651608269, NULL),
       (325, '877', 'Тысяча условных единиц', '10^3 усл. ед', '', 'ТЫС УСЛ ЕД', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (326, '878', 'Миллион условных единиц', '10^6 усл. ед', '', 'МЛН УСЛ ЕД', '', NULL, NULL, NULL, 1651608269,
        1651608269, NULL),
       (327, '879', 'Условная штука', 'усл. шт', '', 'УСЛ ШТ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (328, '880', 'Тысяча условных штук', '10^3 усл. шт', '', 'ТЫС УСЛ ШТ', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (329, '881', 'Условная банка', 'усл. банк', '', 'УСЛ БАНК', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (330, '882', 'Тысяча условных банок', '10^3 усл. банк', '', 'ТЫС УСЛ БАНК', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (331, '883', 'Миллион условных банок', '10^6 усл. банк', '', 'МЛН УСЛ БАНК', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (332, '884', 'Условный кусок', 'усл. кус', '', 'УСЛ КУС', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (333, '885', 'Тысяча условных кусков', '10^3 усл. кус', '', 'ТЫС УСЛ КУС', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (334, '886', 'Миллион условных кусков', '10^6 усл. кус', '', 'МЛН УСЛ КУС', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (335, '887', 'Условный ящик', 'усл. ящ', '', 'УСЛ ЯЩ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (336, '888', 'Тысяча условных ящиков', '10^3 усл. ящ', '', 'ТЫС УСЛ ЯЩ', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (337, '889', 'Условная катушка', 'усл. кат', '', 'УСЛ КАТ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (338, '890', 'Тысяча условных катушек', '10^3 усл. кат', '', 'ТЫС УСЛ КАТ', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (339, '891', 'Условная плитка', 'усл. плит', '', 'УСЛ ПЛИТ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (340, '892', 'Тысяча условных плиток', '10^3 усл. плит', '', 'ТЫС УСЛ ПЛИТ', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (341, '893', 'Условный кирпич', 'усл. кирп', '', 'УСЛ КИРП', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (342, '894', 'Тысяча условных кирпичей', '10^3 усл. кирп', '', 'ТЫС УСЛ КИРП', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (343, '895', 'Миллион условных кирпичей', '10^6 усл. кирп', '', 'МЛН УСЛ КИРП', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (344, '896', 'Семья', 'семей', '', 'СЕМЕЙ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (345, '897', 'Тысяча семей', '10^3 семей', '', 'ТЫС СЕМЕЙ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (346, '898', 'Миллион семей', '10^6 семей', '', 'МЛН СЕМЕЙ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (347, '899', 'Домохозяйство', 'домхоз', '', 'ДОМХОЗ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (348, '900', 'Тысяча домохозяйств', '10^3 домхоз', '', 'ТЫС ДОМХОЗ', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (349, '901', 'Миллион домохозяйств', '10^6 домхоз', '', 'МЛН ДОМХОЗ', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (350, '902', 'Ученическое место', 'учен. мест', '', 'УЧЕН МЕСТ', '', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (351, '903', 'Тысяча ученических мест', '10^3 учен. мест', '', 'ТЫС УЧЕН МЕСТ', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (352, '904', 'Рабочее место', 'раб. мест', '', 'РАБ МЕСТ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (353, '905', 'Тысяча рабочих мест', '10^3 раб. мест', '', 'ТЫС РАБ МЕСТ', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (354, '906', 'Посадочное место', 'посад. мест', '', 'ПОСАД МЕСТ', '', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (355, '907', 'Тысяча посадочных мест', '10^3 посад. мест', '', 'ТЫС ПОСАД МЕСТ', '', NULL, NULL, NULL,
        1651608270, 1651608270, NULL),
       (356, '908', 'Номер', 'ном', '', 'НОМ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (357, '909', 'Квартира', 'кварт', '', 'КВАРТ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (358, '910', 'Тысяча квартир', '10^3 кварт', '', 'ТЫС КВАРТ', '', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (359, '911', 'Койка', 'коек', '', 'КОЕК', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (360, '912', 'Тысяча коек', '10^3 коек', '', 'ТЫС КОЕК', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (361, '913', 'Том книжного фонда', 'том книжн. фонд', '', 'ТОМ КНИЖН ФОНД', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (362, '914', 'Тысяча томов книжного фонда', '10^3 том. книжн. фонд', '', 'ТЫС ТОМ КНИЖН ФОНД', '', NULL, NULL,
        NULL, 1651608270, 1651608270, NULL),
       (363, '915', 'Условный ремонт', 'усл. рем', '', 'УСЛ РЕМ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (364, '916', 'Условный ремонт в год', 'усл. рем/год', '', 'УСЛ РЕМ/ГОД', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (365, '917', 'Смена', 'смен', '', 'СМЕН', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (366, '918', 'Лист авторский', 'л. авт', '', 'ЛИСТ АВТ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (367, '920', 'Лист печатный', 'л. печ', '', 'ЛИСТ ПЕЧ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (368, '921', 'Лист учетно-издательский', 'л. уч.-изд', '', 'ЛИСТ УЧ.ИЗД', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (369, '922', 'Знак', 'знак', '', 'ЗНАК', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (370, '923', 'Слово', 'слово', '', 'СЛОВО', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (371, '924', 'Символ', 'символ', '', 'СИМВОЛ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (372, '925', 'Условная труба', 'усл. труб', '', 'УСЛ ТРУБ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (373, '930', 'Тысяча пластин', '10^3 пласт', '', 'ТЫС ПЛАСТ', '', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (374, '937', 'Миллион доз', '10^6 доз', '', 'МЛН ДОЗ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (375, '949', 'Миллион листов-оттисков', '10^6 лист.оттиск', '', 'МЛН ЛИСТ.ОТТИСК', '', NULL, NULL, NULL,
        1651608270, 1651608270, NULL),
       (376, '950', 'Вагоно(машино)-день', 'ваг (маш).дн', '', 'ВАГ (МАШ).ДН', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (377, '951', 'Тысяча вагоно-(машино)-часов', '10^3 ваг (маш).ч', '', 'ТЫС ВАГ (МАШ).Ч', '', NULL, NULL, NULL,
        1651608270, 1651608270, NULL),
       (378, '952', 'Тысяча вагоно-(машино)-километров', '10^3 ваг (маш).км', '', 'ТЫС ВАГ (МАШ).КМ', '', NULL, NULL,
        NULL, 1651608270, 1651608270, NULL),
       (379, '953', 'Тысяча место-километров', '10 ^3мест.км', '', 'ТЫС МЕСТ.КМ', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (380, '954', 'Вагоно-сутки', 'ваг.сут', '', 'ВАГ.СУТ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (381, '955', 'Тысяча поездо-часов', '10^3 поезд.ч', '', 'ТЫС ПОЕЗД.Ч', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (382, '956', 'Тысяча поездо-километров', '10^3 поезд.км', '', 'ТЫС ПОЕЗД.КМ', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (383, '957', 'Тысяча тонно-миль', '10^3 т.миль', '', 'ТЫС Т.МИЛЬ', '', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (384, '958', 'Тысяча пассажиро-миль', '10^3 пасс.миль', '', 'ТЫС ПАСС.МИЛЬ', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (385, '959', 'Автомобиле-день', 'автомоб.дн', '', 'АВТОМОБ.ДН', '', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (386, '960', 'Тысяча автомобиле-тонно-дней', '10^3 автомоб.т.дн', '', 'ТЫС АВТОМОБ.Т.ДН', '', NULL, NULL, NULL,
        1651608270, 1651608270, NULL),
       (387, '961', 'Тысяча автомобиле-часов', '10^3 автомоб.ч', '', 'ТЫС АВТОМОБ.Ч', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (388, '962', 'Тысяча автомобиле-место-дней', '10^3 автомоб.мест. дн', '', 'ТЫС АВТОМОБ.МЕСТ. ДН', '', NULL, NULL,
        NULL, 1651608270, 1651608270, NULL),
       (389, '963', 'Приведенный час', 'привед.ч', '', 'ПРИВЕД.Ч', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (390, '964', 'Самолето-километр', 'самолет.км', '', 'САМОЛЕТ.КМ', '', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (391, '965', 'Тысяча километров', '10^3 км', '', 'ТЫС КМ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (392, '966', 'Тысяча тоннаже-рейсов', '10^3 тоннаж. рейс', '', 'ТЫС ТОННАЖ. РЕЙС', '', NULL, NULL, NULL,
        1651608270, 1651608270, NULL),
       (393, '967', 'Миллион тонно-миль', '10^6 т. миль', '', 'МЛН Т. МИЛЬ', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (394, '968', 'Миллион пассажиро-миль', '10^6 пасс. миль', '', 'МЛН ПАСС. МИЛЬ', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (395, '969', 'Миллион тоннаже-миль', '10^6 тоннаж. миль', '', 'МЛН ТОННАЖ. МИЛЬ', '', NULL, NULL, NULL,
        1651608270, 1651608270, NULL),
       (396, '970', 'Миллион пассажиро-место-миль', '10^6 пасс. мест. миль', '', 'МЛН ПАСС. МЕСТ. МИЛЬ', '', NULL, NULL,
        NULL, 1651608270, 1651608270, NULL),
       (397, '971', 'Кормо-день', 'корм. дн', '', 'КОРМ. ДН', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (398, '972', 'Центнер кормовых единиц', 'ц корм ед', '', 'Ц КОРМ ЕД', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (399, '973', 'Тысяча автомобиле-километров', '10^3 автомоб. км', '', 'ТЫС АВТОМОБ. КМ', '', NULL, NULL, NULL,
        1651608270, 1651608270, NULL),
       (400, '974', 'Тысяча тоннаже-сут', '10^3 тоннаж. сут', '', 'ТЫС ТОННАЖ. СУТ', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (401, '975', 'Суго-сутки', 'суго. сут.', '', 'СУГО. СУТ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (402, '976', 'Штук в 20-футовом эквиваленте (ДФЭ)', 'штук в 20-футовом эквиваленте', '', 'ШТ В 20 ФУТ ЭКВИВ', '',
        NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (403, '977', 'Канало-километр', 'канал. км', '', 'КАНАЛ. КМ', '', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (404, '978', 'Канало-концы', 'канал. конц', '', 'КАНАЛ. КОНЦ', '', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (405, '979', 'Тысяча экземпляров', '10^3 экз', '', 'ТЫС ЭКЗ', '', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (406, '980', 'Тысяча долларов', '10^3 доллар', '', 'ТЫС ДОЛЛАР', '', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (407, '981', 'Тысяча тонн кормовых единиц', '10^3 корм ед', '', 'ТЫС Т КОРМ ЕД', '', NULL, NULL, NULL,
        1651608270, 1651608270, NULL),
       (408, '982', 'Миллион тонн кормовых единиц', '10^6 корм ед', '', 'МЛН Т КОРМ ЕД', '', NULL, NULL, NULL,
        1651608270, 1651608270, NULL),
       (409, '983', 'Судо-сутки', 'суд.сут', '', 'СУД.СУТ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (410, '017', 'Гектометр', '', 'hm', '', 'HMT', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (411, '045', 'Миля (уставная) (1609,344 м)', '', 'mile', '', 'SMI', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (412, '077', 'Акр (4840 квадратных ярдов)', '', 'acre', '', 'ACR', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (413, '079', 'Квадратная миля', '', 'mile2', '', 'MIK', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (414, '135', 'Жидкостная унция СК (28,413 см3)', '', 'fl oz (UK)', '', 'OZI', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (415, '136', 'Джилл СК (0,142065 дм3)', '', 'gill (UK)', '', 'GII', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (416, '137', 'Пинта СК (0,568262 дм3)', '', 'pt (UK)', '', 'PTI', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (417, '138', 'Кварта СК (1,136523 дм3)', '', 'qt (UK)', '', 'QTI', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (418, '139', 'Галлон СК (4,546092 дм3)', '', 'gal (UK)', '', 'GLI', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (419, '140', 'Бушель СК (36,36874 дм3)', '', 'bu (UK)', '', 'BUI', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (420, '141', 'Жидкостная унция США (29,5735 см3)', '', 'fl oz (US)', '', 'OZA', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (421, '142', 'Джилл США (11,8294 см3)', '', 'gill (US)', '', 'GIA', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (422, '143', 'Жидкостная пинта США (0,473176 дм3)', '', 'liq pt (US)', '', 'PTL', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (423, '144', 'Жидкостная кварта США (0,946353 дм3)', '', 'liq qt (US)', '', 'QTL', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (424, '145', 'Жидкостный галлон США (3,78541 дм3)', '', 'gal (US)', '', 'GLL', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (425, '146', 'Баррель (нефтяной) США (158,987 дм3)', '', 'barrel (US)', '', 'BLL', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (426, '147', 'Сухая пинта США (0,55061 дм3)', '', 'dry pt (US)', '', 'PTD', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (427, '148', 'Сухая кварта США (1,101221 дм3)', '', 'dry qt (US)', '', 'QTD', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (428, '149', 'Сухой галлон США (4,404884 дм3)', '', 'dry gal (US)', '', 'GLD', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (429, '150', 'Бушель США (35,2391 дм3)', '', 'bu (US)', '', 'BUA', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (430, '151', 'Сухой баррель США (115,627 дм3)', '', 'bbl (US)', '', 'BLD', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (431, '152', 'Стандарт', '', '-', '', 'WSD', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (432, '153', 'Корд (3,63 м3)', '', '-', '', 'WCD', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (433, '154', 'Тысячи бордфутов (2,36 м3)', '', '-', '', 'MBF', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (434, '182', 'Нетто-регистровая тонна', '', '-', '', 'NTT', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (435, '183', 'Обмерная (фрахтовая) тонна', '', '-', '', 'SHT', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (436, '184', 'Водоизмещение', '', '-', '', 'DPT', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (437, '186', 'Фунт СК, США (0,45359237 кг)', '', 'lb', '', 'LBR', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (438, '187', 'Унция СК, США (28,349523 г)', '', 'oz', '', 'ONZ', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (439, '188', 'Драхма СК (1,771745 г)', '', 'dr', '', 'DRI', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (440, '189', 'Гран СК, США (64,798910 мг)', '', 'gn', '', 'GRN', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (441, '190', 'Стоун СК (6,350293 кг)', '', 'st', '', 'STI', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (442, '191', 'Квартер СК (12,700586 кг)', '', 'qtr', '', 'QTR', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (443, '192', 'Центал СК (45,359237 кг)', '', '-', '', 'CNT', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (444, '193', 'Центнер США (45,3592 кг)', '', 'cwt', '', 'CWA', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (445, '194', 'Длинный центнер СК (50,802345 кг)', '', 'cwt (UK)', '', 'CWI', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (446, '195', 'Короткая тонна СК, США (0,90718474 т) [2*]', '', 'sht', '', 'STN', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (447, '196', 'Длинная тонна СК, США (1,0160469 т) [2*]', '', 'lt', '', 'LTN', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (448, '197', 'Скрупул СК, США (1,295982 г)', '', 'scr', '', 'SCR', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (449, '198', 'Пеннивейт СК, США (1,555174 г)', '', 'dwt', '', 'DWT', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (450, '199', 'Драхма СК (3,887935 г)', '', 'drm', '', 'DRM', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (451, '200', 'Драхма США (3,887935 г)', '', '-', '', 'DRA', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (452, '201', 'Унция СК, США (31,10348 г); тройская унция', '', 'apoz', '', 'APZ', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (453, '202', 'Тройский фунт США (373,242 г)', '', '-', '', 'LBT', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (454, '213', 'Эффективная мощность (245,7 ватт)', '', 'B.h.p.', '', 'BHP', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (455, '275', 'Британская тепловая единица (1,055 кДж)', '', 'Btu', '', 'BTU', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (456, '638', 'Гросс (144 шт.)', '', 'gr; 144', '', 'GRO', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (457, '731', 'Большой гросс (12 гроссов)', '', '1728', '', 'GGR', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (458, '738', 'Короткий стандарт (7200 единиц)', '', '-', '', 'SST', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (459, '835', 'Галлон спирта установленной крепости', '', '-', '', 'PGL', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (460, '851', 'Международная единица', '', '-', '', 'NIU', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (461, '853', 'Сто международных единиц', '', '-', '', 'HIU', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (462, '2545', 'Мегабит в секунду', 'Мбит/с', '', 'МБИТ/С', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (463, '2547', 'Гигабит в секунду', 'Гбит/с', '', 'ГБИТ/С', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (464, '2551', 'Байт в секунду', 'Байт/с', '', 'БАЙТ/С', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (465, '2552', 'Гигабайт в секунду', 'Гбайт/с', '', 'ГБАЙТ/С', '', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (466, '2561', 'Килобайт в секунду', 'кбайт/с', '', 'КБАЙТ/С', '', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (467, '2571', 'Мегабайт в секунду', 'Мбайт/с', '', 'МБАЙТ/С', '', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (468, '2581', 'Эрланг', 'Эрл', '', 'ЭРЛАНГ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (469, '276', 'Грей', 'Гр', 'Gy', 'ГР', 'GY', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (470, '3135', 'Децибел', 'Дб', '', 'ДЕЦИБЕЛ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (471, '7923', 'Абонент', 'Абонент', '', 'АБОНЕНТ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (472, '9061', 'Миллион гектаров', '10^6 га', '', 'МЛН ГА', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (473, '9062', 'Миллиард гектаров', '10^9 га', '', 'МЛРД ГА', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (474, '9557', 'Миллион голов', '10^6 гол', '', 'МЛН ГОЛ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (475, '9642', 'Балл', 'балл', '', 'БАЛЛ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (476, '9802', 'Миллион долларов', '10^6 доллар', '', 'МЛН ДОЛЛАР', '', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (477, '984', 'Центнеров с гектара', 'ц/га', '', 'Ц/ГА', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (478, '985', 'Тысяча голов', '10^3 гол', '', 'ТЫС ГОЛ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (479, '986', 'Тысяча краско-оттисков', '10^3 краск. оттиск', '', 'ТЫС КРАСК ОТТИСК', '', NULL, NULL, NULL,
        1651608270, 1651608270, NULL),
       (480, '987', 'Миллион краско-оттисков', '10^6 краск. оттиск', '', 'МЛН КРАСК ОТТИСК', '', NULL, NULL, NULL,
        1651608270, 1651608270, NULL),
       (481, '988', 'Миллион условных плиток', '10^6 усл. плит', '', 'МЛН УСЛ ПЛИТ', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (482, '989', 'Человек в час', 'чел/ч', '', 'ЧЕЛ/Ч', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (483, '990', 'Пассажиров в час', 'пасс/ч', '', 'ПАСС/Ч', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (484, '991', 'Пассажиро-миля', 'пасс. миля', '', 'ПАСС МИЛЯ', '', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (485, '2553', 'Гигабайт', 'Гбайт', '', 'ГБАЙТ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (486, '2554', 'Терабайт', 'Тбайт', '', 'ТБАЙТ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (487, '2555', 'Петабайт', 'Пбайт', '', 'ПБАЙТ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (488, '2556', 'Эксабайт', 'Эбайт', '', 'ЭБАЙТ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (489, '2557', 'Зеттабайт', 'Збайт', '', 'ЗБАЙТ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (490, '2558', 'Йоттабайт', 'Йбайт', '', 'ЙБАЙТ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (491, '3831', 'Рубль тонна', 'руб. тонна', '', 'РУБ ТОННА', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (492, '5401', 'Дето-день', 'дет. дн', '', 'ДЕТ ДН', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (493, '5423', 'Человек в год', 'чел/год', '', 'ЧЕЛ/ГОД', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (494, '5451', 'Посещение', 'посещ', '', 'ПОСЕЩ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (495, '5562', 'Тысяча гнезд', '10^3 гнезд', '', 'ТЫС ГНЕЗД', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (496, '6421', 'Единиц в год', 'ед/год', '', 'ЕД/ГОД', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (497, '6422', 'Вызов', 'вызов', '', 'ВЫЗОВ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (498, '6424', 'Штамм', 'штамм', '', 'ШТАММ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (499, '8361', 'Особь', 'ос', '', 'ОСОБЬ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (500, '8751', 'Коробка', 'кор', '', 'КОР', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (501, '9111', 'Койко-день', 'койк. дн', '', 'КОЙК ДН', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (502, '9113', 'Пациенто-день', 'пациент. дн', '', 'ПАЦИЕНТ ДН', '', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (503, '9245', 'Запись', 'запись', '', 'ЗАПИСЬ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (504, '9246', 'Документ', 'докум', '', 'ДОКУМ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (505, '9491', 'Лист-оттиск', 'лист. оттиск', '', 'ЛИСТ. ОТТИСК', '', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (506, '9501', 'Вагоно (машино)-час', 'ваг (маш) ч', '', 'ВАГ (МАШ) Ч', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (507, '9641', 'Летный час', 'летн. ч', '', 'ЛЕТН Ч', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (508, '9803', 'Миллиард долларов', '10^9 доллар', '', 'МЛРД ДОЛЛАР', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (509, '9805', 'Доллар за тонну', 'доллар за тонну', '', 'ДОЛЛАР ЗА ТОННУ', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (510, '6423', 'Посевная единица', 'пос.ед', '', 'ПОС.ЕД', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (511, '508', 'Тысяча метров кубических в час', '103 м^3/ч', '', 'ТЫС М3/Ч', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (512, '164', 'Микрограмм', 'мкг', 'mg', 'МКГ', 'MG', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (513, '303', 'Килобеккерель', 'кБк', 'kBq', 'КИЛОБК', 'KBQ', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (514, '307', 'Мегабеккерель', 'МБк', 'MBq', 'МЕГАБК', 'MBQ', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (515, '320', 'Моль', 'моль', 'mol', 'МОЛЬ', 'MOL', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (516, '9910', 'Международная единица биологической активности', 'МЕ', '', 'МЕ', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (517, '9911', 'Тысяча международных единиц биологической активности', 'тыс. МЕ', '', 'ТЫС. МЕ', '', NULL, NULL,
        NULL, 1651608270, 1651608270, NULL),
       (518, '9912', 'Миллион международных единиц биологической активности', 'млн. МЕ', '', 'МЛН. МЕ', '', NULL, NULL,
        NULL, 1651608270, 1651608270, NULL),
       (519, '9913', 'Международная единица биологической активности на грамм', 'МЕ/г', '', 'МЕ/Г', '', NULL, NULL,
        NULL, 1651608270, 1651608270, NULL),
       (520, '9914', 'Тысяча международных единиц биологической активности на грамм', 'тыс. МЕ/г', '', 'ТЫС. МЕ/Г', '',
        NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (521, '9915', 'Миллион международных единиц биологической активности на грамм', 'млн. МЕ/г', '', 'МЛН. МЕ/Г', '',
        NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (522, '9916', 'Международная единица биологической активности на миллилитр', 'МЕ/мл', '', 'МЕ/МЛ', '', NULL,
        NULL, NULL, 1651608270, 1651608270, NULL),
       (523, '9917', 'Тысяча международных единиц биологической активности на миллилитр', 'тыс. МЕ/мл', '',
        'ТЫС. МЕ/МЛ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (524, '9918', 'Миллион международных единиц биологической активности на миллилитр', 'млн. МЕ/мл', '',
        'МЛН. МЕ/МЛ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (525, '9920', 'Единица действия биологической активности', 'ЕД', '', 'ЕД', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (526, '9921', 'Единица биологической активности на грамм', 'ЕД/г', '', 'ЕД/Г', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (527, '9922', 'Тысяча единиц действия биологической активности на грамм', 'тыс. ЕД/г', '', 'ТЫС. ЕД/Г', '', NULL,
        NULL, NULL, 1651608270, 1651608270, NULL),
       (528, '9923', 'Единица действия биологической активности на микролитр', 'ЕД/мкл', '', 'ЕД/МКЛ', '', NULL, NULL,
        NULL, 1651608270, 1651608270, NULL),
       (529, '9924', 'Единица действия биологической активности на миллилитр', 'ЕД/мл', '', 'ЕД/МЛ', '', NULL, NULL,
        NULL, 1651608270, 1651608270, NULL),
       (530, '9925', 'Тысяча единиц действия биологической активности на миллилитр', 'тыс. ЕД/мл', '', 'ТЫС. ЕД/МЛ', '',
        NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (531, '9926', 'Миллион единиц действия биологической активности на миллилитр', 'млн. ЕД/мл', '', 'МЛН. ЕД/МЛ',
        '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (532, '9927', 'Единица действия биологической активности в сутки', 'ЕД/сут', '', 'ЕД/СУТ', '', NULL, NULL, NULL,
        1651608270, 1651608270, NULL),
       (533, '9930', 'Антитоксическая единица', 'АЕ', '', 'АЕ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (534, '9931', 'Тысяча антитоксических единиц', 'тыс. АЕ', '', 'ТЫС. АЕ', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (535, '9940', 'Антитрипсиновая единица', 'АТрЕ', '', 'АТРЕ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (536, '9941', 'Тысяча антитрипсиновых единиц', 'тыс. АТрЕ', '', 'ТЫС. АТРЕ', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (537, '9950', 'Индекс Реактивности', 'ИР', '', 'ИР', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (538, '9951', 'Индекс Реактивности на миллилитр', 'ИР/мл', '', 'ИР/МЛ', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (539, '9960', 'Килобеккерель на миллилитр', 'кБк/мл', '', 'КИЛОБК/МЛ', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (540, '9961', 'Мегабеккерель на миллилитр', 'МБк/мл', '', 'МЕГАБК/МЛ', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (541, '9962', 'Мегабеккерель на метр квадратный', 'МБк/м2', '', 'МЕГАБК/М2', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (542, '9970', 'Калликреиновая ингибирующая единица на миллилитр', 'КИЕ/мл', '', 'КИЕ/МЛ', '', NULL, NULL, NULL,
        1651608270, 1651608270, NULL),
       (543, '9971', 'Тысяча калликреиновых ингибирующих единиц на миллилитр', 'тыс. КИЕ/МЛ', '', 'ТЫС. КИЕ/МЛ', '',
        NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (544, '9980', 'Миллион колониеобразующих единиц', 'млн. КОЕ', '', 'МЛН. КОЕ', '', NULL, NULL, NULL, 1651608270,
        1651608270, NULL),
       (545, '9981', 'Миллион колониеобразующих единиц на пакет', 'млн. КОЕ/пакет', '', 'МЛН. КОЕ/ПАКЕТ', '', NULL,
        NULL, NULL, 1651608270, 1651608270, NULL),
       (546, '9982', 'Миллиард колониеобразующих единиц', 'млрд. КОЕ', '', 'МЛРД. КОЕ', '', NULL, NULL, NULL,
        1651608270, 1651608270, NULL),
       (547, '9983', 'Протеолитическая единица', 'ПЕ', '', 'ПЕ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (548, '9985', 'Микрограмм на миллилитр', 'Мкг/мл', '', 'МКГ/МЛ', '', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (549, '9986', 'Микрограмм в сутки', 'Мкг/сут', '', 'МГК/СУТ', '', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (550, '9987', 'Микрограмм в час', 'Мкг/ч', '', 'МКГ/Ч', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (551, '9988', 'Микрограмм на дозу', 'Мкг/доза', '', 'МКГ/ДОЗА', '', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (552, '9990', 'Миллимоль на миллилитр', 'моль/мл', '', 'ММОЛЬ/МЛ', '', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (553, '9991', 'Миллимоль на литр', 'ммоль/л', '', 'ММОЛЬ/Л', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (554, '728', 'Пачка', 'пач', '', 'ПАЧ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (555, '509', 'Километр в сутки', 'км/сут', '', 'КМ/СУТ', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (556, '277', 'Микрогрей', 'мкГр', 'μGy', 'МКГР', 'MKGY', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (557, '278', 'Миллигрей', 'мГр', 'mGy', 'МЛГР', 'MGY', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (558, '279', 'Килогрей', 'кГр', 'kGy', 'КИЛОГР', 'KGY', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (559, '293', 'Гигагерц', 'ГГц', 'GHz', 'ГИГАГЦ', 'GHZ', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (560, '295', 'Терагерц', 'ТГц', 'THz', 'ТЕРАГЦ', 'THZ', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (561, '351', 'Наносекунда', 'нс', '', 'НС', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (562, '318', 'Зиверт', 'Зв', 'Sv', 'ЗВ', 'SV', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (563, '319', 'Микрозиверт', 'мкЗв', 'μSv', 'МКЗВ', 'MKSV', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (564, '321', 'Миллизиверт', 'мЗв', 'mSv', 'МЗВ', 'MSV', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (565, '348', 'Фемтосекунда', 'фс', '', 'ФС', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (566, '350', 'Пикосекунда', 'пс', '', 'ПС', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (567, '2311', 'Грей в секунду', 'Гр/с', '', 'ГР/С', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (568, '2312', 'Грей в минуту', 'Гр/мин', '', 'ГР/МИН', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (569, '2313', 'Грей в час', 'Гр/ч', '', 'ГР/Ч', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (570, '2314', 'Микрогрей в секунду', 'мкГр/с', '', 'МКГР/С', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (571, '2315', 'Микрогрей в час', 'мкГр/ч', '', 'МКГР/Ч', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (572, '2316', 'Миллигрей в час', 'мГр/ч', '', 'МЛГР/Ч', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (573, '2351', 'Зиверт в час', 'Зв/ч', '', 'ЗВ/Ч', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (574, '2352', 'Микрозиверт в секунду', 'мкЗв/с', '', 'МКЗВ/С', '', NULL, NULL, NULL, 1651608270, 1651608270,
        NULL),
       (575, '2353', 'Микрозиверт в час', 'мкЗв/ч', '', 'МКЗВ/Ч', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (576, '2354', 'Миллизиверт в час', 'мЗв/ч', '', 'МЛВЗ/Ч', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (577, '2355', 'Градус (плоского угла)', '', '', '', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (578, '2356', 'Минута (плоского угла)', '', '', '', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (579, '2357', 'Секунда (плоского угла)', '', '', '', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (580, '426', 'Пар грузовых поездов в сутки', 'пар груз поезд/сут', '', 'Пар Груз Поезд/Сут', '', NULL, NULL,
        NULL, 1651608270, 1651608270, NULL),
       (581, '747', 'Базисный пункт', 'б.п.', '', 'БП', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL),
       (582, '340', 'Грамм условного топлива на киловатт-час', 'г у.т./кВт•ч', '', 'Г У.Т./КВТ•Ч', '', NULL, NULL, NULL,
        1651608270, 1651608270, NULL),
       (583, '341', 'Килограмм условного топлива на гигакалорию', 'кг у.т./Гкал', '', 'КГ У.Т./ГКАЛ', '', NULL, NULL,
        NULL, 1651608270, 1651608270, NULL),
       (584, '9823', 'Миллиард евро', '10^9 евро', '', 'МЛРД ЕВРО', '', NULL, NULL, NULL, 1651608270, 1651608270, NULL);

DROP TABLE IF EXISTS `ax_user`;
CREATE TABLE `ax_user`
(
    `id`                   bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `first_name`           varchar(255)        NOT NULL DEFAULT 'Undefined',
    `last_name`            varchar(255)        NOT NULL DEFAULT 'Undefined',
    `patronymic`           varchar(255)                 DEFAULT NULL,
    `phone`                varchar(255)                 DEFAULT NULL,
    `email`                varchar(255)                 DEFAULT NULL,
    `is_email`             tinyint(1) unsigned          DEFAULT '0',
    `is_phone`             tinyint(1) unsigned          DEFAULT '0',
    `state`                smallint(6)         NOT NULL DEFAULT '0',
    `password_hash`        varchar(255)        NOT NULL,
    `remember_token`       varchar(500)                 DEFAULT NULL,
    `auth_key`             varchar(32)                  DEFAULT NULL,
    `password_reset_token` varchar(255)                 DEFAULT NULL,
    `created_at`           int(11) unsigned             DEFAULT NULL,
    `updated_at`           int(11) unsigned             DEFAULT NULL,
    `deleted_at`           int(11) unsigned             DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    UNIQUE KEY `email` (`email`),
    UNIQUE KEY `password_reset_token` (`password_reset_token`),
    UNIQUE KEY `phone_UNIQUE` (`phone`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO `ax_user` (`id`, `first_name`, `last_name`, `patronymic`, `phone`, `email`, `is_email`, `is_phone`, `state`,
                       `password_hash`, `remember_token`, `auth_key`, `password_reset_token`, `created_at`,
                       `updated_at`, `deleted_at`)
VALUES (6, 'Алексей', 'Алексеев', 'Александрович', '79621829550', 'axlle@mail.ru', 1, 0, 10,
        '$2y$13$DMqEjJJL9gjftb80gCt5n.fOTyoTfAEv/HsQPh2IEQa42bfNsfF5S', 'kyyBBbb80b3ZflMDdsynKC0B4skxf_gF',
        'kyyBBbb80b3ZflMDdsynKC0B4skxf_gF', NULL, 1651608268, NULL, NULL);

DROP TABLE IF EXISTS `ax_user_guest`;
CREATE TABLE `ax_user_guest`
(
    `id`         bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `email`      varchar(255)        NOT NULL,
    `name`       varchar(255)     DEFAULT NULL,
    `created_at` int(11) unsigned DEFAULT NULL,
    `updated_at` int(11) unsigned DEFAULT NULL,
    `deleted_at` int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_user_profile`;
CREATE TABLE `ax_user_profile`
(
    `id`                       bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `user_id`                  bigint(20) unsigned NOT NULL,
    `catalog_delivery_type_id` bigint(20) unsigned DEFAULT NULL,
    `catalog_payment_type_id`  bigint(20) unsigned DEFAULT NULL,
    `title`                    varchar(255)        NOT NULL,
    `description`              text,
    `image`                    varchar(255)        DEFAULT NULL,
    `created_at`               int(11) unsigned    DEFAULT NULL,
    `updated_at`               int(11) unsigned    DEFAULT NULL,
    `deleted_at`               int(11) unsigned    DEFAULT NULL,
    PRIMARY KEY (`id`, `user_id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    KEY `fk_ax_user_profile_ax_catalog_delivery_type1_idx` (`catalog_delivery_type_id`),
    KEY `fk_ax_user_profile_ax_catalog_payment_type1_idx` (`catalog_payment_type_id`),
    KEY `fk_ax_user_profile_ax_user1_idx` (`user_id`),
    CONSTRAINT `fk_ax_user_profile_ax_catalog_delivery_type1` FOREIGN KEY (`catalog_delivery_type_id`) REFERENCES `ax_catalog_delivery_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_user_profile_ax_catalog_payment_type1` FOREIGN KEY (`catalog_payment_type_id`) REFERENCES `ax_catalog_payment_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_user_profile_ax_user1` FOREIGN KEY (`user_id`) REFERENCES `ax_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_user_token`;
CREATE TABLE `ax_user_token`
(
    `id`         bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `user_id`    bigint(20) unsigned NOT NULL,
    `type`       varchar(45)         NOT NULL,
    `token`      varchar(800)        NOT NULL,
    `created_at` int(11) unsigned DEFAULT NULL,
    `updated_at` int(11) unsigned DEFAULT NULL,
    `deleted_at` int(11) unsigned DEFAULT NULL,
    `expired_at` int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`, `user_id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    UNIQUE KEY `value_UNIQUE` (`token`),
    KEY `fk_table1_ax_user1_idx` (`user_id`),
    CONSTRAINT `fk_table1_ax_user1` FOREIGN KEY (`user_id`) REFERENCES `ax_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_wallet`;
CREATE TABLE `ax_wallet`
(
    `id`                 bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `user_id`            bigint(20) unsigned NOT NULL,
    `wallet_currency_id` bigint(20) unsigned NOT NULL,
    `balance`            float unsigned   DEFAULT '0',
    `created_at`         int(11) unsigned DEFAULT NULL,
    `updated_at`         int(11) unsigned DEFAULT NULL,
    `deleted_at`         int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`, `user_id`, `wallet_currency_id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    KEY `fk_ax_wallet_ax_user1_idx` (`user_id`),
    KEY `fk_ax_wallet_ax_wallet_currency1_idx` (`wallet_currency_id`),
    CONSTRAINT `fk_ax_wallet_ax_user1` FOREIGN KEY (`user_id`) REFERENCES `ax_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_wallet_ax_wallet_currency1` FOREIGN KEY (`wallet_currency_id`) REFERENCES `ax_wallet_currency` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_wallet_currency`;
CREATE TABLE `ax_wallet_currency`
(
    `id`          bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `currency_id` bigint(20) unsigned NOT NULL,
    `name`        varchar(50)         NOT NULL,
    `title`       varchar(45)         NOT NULL,
    `is_national` tinyint(1) unsigned NOT NULL,
    `created_at`  int(11) unsigned DEFAULT NULL,
    `updated_at`  int(11) unsigned DEFAULT NULL,
    `deleted_at`  int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`, `currency_id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    KEY `fk_ax_wallet_currency_ax_currency1_idx` (`currency_id`),
    CONSTRAINT `fk_ax_wallet_currency_ax_currency1` FOREIGN KEY (`currency_id`) REFERENCES `ax_currency` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO `ax_wallet_currency` (`id`, `currency_id`, `name`, `title`, `is_national`, `created_at`, `updated_at`,
                                  `deleted_at`)
VALUES (1, 12, 'USD', 'Доллар США', 0, 1651608268, 1651608268, NULL),
       (2, 1, 'RUB', 'Российский рубль', 1, 1651608268, 1651608268, NULL);

DROP TABLE IF EXISTS `ax_wallet_transaction`;
CREATE TABLE `ax_wallet_transaction`
(
    `id`                            bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `wallet_id`                     bigint(20) unsigned NOT NULL,
    `wallet_currency_id`            bigint(20) unsigned NOT NULL,
    `wallet_transaction_subject_id` bigint(20) unsigned NOT NULL,
    `type`                          varchar(45)         NOT NULL,
    `value`                         decimal(10, 0)      DEFAULT '0',
    `resource`                      varchar(255)        DEFAULT NULL,
    `resource_id`                   bigint(20) unsigned DEFAULT NULL,
    `created_at`                    int(11) unsigned    DEFAULT NULL,
    `updated_at`                    int(11) unsigned    DEFAULT NULL,
    `deleted_at`                    int(11) unsigned    DEFAULT NULL,
    PRIMARY KEY (`id`, `wallet_id`, `wallet_currency_id`, `wallet_transaction_subject_id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    KEY `fk_ax_wallet_transaction_ax_wallet1_idx` (`wallet_id`),
    KEY `fk_ax_wallet_transaction_ax_wallet_currency1_idx` (`wallet_currency_id`),
    KEY `fk_ax_wallet_transaction_ax_wallet_transaction_subject1_idx` (`wallet_transaction_subject_id`),
    CONSTRAINT `fk_ax_wallet_transaction_ax_wallet1` FOREIGN KEY (`wallet_id`) REFERENCES `ax_wallet` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_wallet_transaction_ax_wallet_currency1` FOREIGN KEY (`wallet_currency_id`) REFERENCES `ax_wallet_currency` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_wallet_transaction_ax_wallet_transaction_subject1` FOREIGN KEY (`wallet_transaction_subject_id`) REFERENCES `ax_wallet_transaction_subject` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_wallet_transaction_subject`;
CREATE TABLE `ax_wallet_transaction_subject`
(
    `id`                      bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `fin_transaction_type_id` bigint(20) unsigned NOT NULL,
    `name`                    varchar(45)         NOT NULL,
    `title`                   varchar(500)        NOT NULL,
    `created_at`              int(11) unsigned DEFAULT NULL,
    `updated_at`              int(11) unsigned DEFAULT NULL,
    `deleted_at`              int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`, `fin_transaction_type_id`),
    UNIQUE KEY `name_UNIQUE` (`name`),
    KEY `fk_ax_wallet_transaction_subject_ax_fin_transaction_type1_idx` (`fin_transaction_type_id`),
    CONSTRAINT `fk_ax_wallet_transaction_subject_ax_fin_transaction_type1` FOREIGN KEY (`fin_transaction_type_id`) REFERENCES `ax_fin_transaction_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO `ax_wallet_transaction_subject` (`id`, `fin_transaction_type_id`, `name`, `title`, `created_at`,
                                             `updated_at`, `deleted_at`)
VALUES (1, 1, 'stock', 'Покупка', 1651608268, 1651608268, NULL),
       (2, 2, 'refund', 'Возврат', 1651608268, 1651608268, NULL),
       (3, 1, 'transfer', 'Перевод', 1651608268, 1651608268, NULL);

DROP TABLE IF EXISTS `ax_widgets`;
CREATE TABLE `ax_widgets`
(
    `id`          bigint(20) unsigned NOT NULL,
    `render_id`   bigint(20) unsigned DEFAULT NULL,
    `name`        varchar(255)        NOT NULL,
    `title`       varchar(255)        NOT NULL,
    `description` varchar(255)        DEFAULT NULL,
    `created_at`  int(11) unsigned    DEFAULT NULL,
    `updated_at`  int(11) unsigned    DEFAULT NULL,
    `deleted_at`  int(11) unsigned    DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    UNIQUE KEY `name_UNIQUE` (`name`),
    KEY `fk_ax_widgets_ax_render1_idx` (`render_id`),
    CONSTRAINT `fk_ax_widgets_ax_render1` FOREIGN KEY (`render_id`) REFERENCES `ax_render` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_widgets_has_resource`;
CREATE TABLE `ax_widgets_has_resource`
(
    `widgets_id`  bigint(20) unsigned NOT NULL,
    `resource`    varchar(255)        NOT NULL,
    `resource_id` bigint(20) unsigned NOT NULL,
    PRIMARY KEY (`widgets_id`, `resource`, `resource_id`),
    KEY `fk_ax_post_has_ax_widgets_ax_widgets1_idx` (`widgets_id`),
    CONSTRAINT `fk_ax_post_has_ax_widgets_ax_widgets1` FOREIGN KEY (`widgets_id`) REFERENCES `ax_widgets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_widgets_has_value_decimal`;
CREATE TABLE `ax_widgets_has_value_decimal`
(
    `id`                  bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `widgets_id`          bigint(20) unsigned NOT NULL,
    `widgets_property_id` bigint(20) unsigned NOT NULL,
    `value`               decimal(10, 2)      NOT NULL,
    `sort`                int(11)          DEFAULT '100',
    `created_at`          int(11) unsigned DEFAULT NULL,
    `updated_at`          int(11) unsigned DEFAULT NULL,
    `deleted_at`          int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`, `widgets_id`, `widgets_property_id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    KEY `fk_ax_catalog_product_has_value_decimal_copy1_ax_widgets_pr_idx` (`widgets_property_id`),
    KEY `fk_ax_widgets_has_value_decimal_ax_widgets1_idx` (`widgets_id`),
    CONSTRAINT `fk_ax_catalog_product_has_value_decimal_copy1_ax_widgets_prop1` FOREIGN KEY (`widgets_property_id`) REFERENCES `ax_widgets_property` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_widgets_has_value_decimal_ax_widgets1` FOREIGN KEY (`widgets_id`) REFERENCES `ax_widgets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_widgets_has_value_int`;
CREATE TABLE `ax_widgets_has_value_int`
(
    `id`                  bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `widgets_id`          bigint(20) unsigned NOT NULL,
    `widgets_property_id` bigint(20) unsigned NOT NULL,
    `value`               int(11)             NOT NULL,
    `sort`                int(11)          DEFAULT '100',
    `created_at`          int(11) unsigned DEFAULT NULL,
    `updated_at`          int(11) unsigned DEFAULT NULL,
    `deleted_at`          int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`, `widgets_id`, `widgets_property_id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    KEY `fk_ax_catalog_product_has_value_int_copy1_ax_widgets_proper_idx` (`widgets_property_id`),
    KEY `fk_ax_widgets_has_value_int_ax_widgets1_idx` (`widgets_id`),
    CONSTRAINT `fk_ax_catalog_product_has_value_int_copy1_ax_widgets_property1` FOREIGN KEY (`widgets_property_id`) REFERENCES `ax_widgets_property` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_widgets_has_value_int_ax_widgets1` FOREIGN KEY (`widgets_id`) REFERENCES `ax_widgets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_widgets_has_value_text`;
CREATE TABLE `ax_widgets_has_value_text`
(
    `id`                  bigint(20) unsigned NOT NULL,
    `widgets_id`          bigint(20) unsigned NOT NULL,
    `widgets_property_id` bigint(20) unsigned NOT NULL,
    `value`               text                NOT NULL,
    `sort`                int(11)          DEFAULT '100',
    `created_at`          int(11) unsigned DEFAULT NULL,
    `updated_at`          int(11) unsigned DEFAULT NULL,
    `deleted_at`          int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`, `widgets_id`, `widgets_property_id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    KEY `fk_ax_catalog_product_has_value_text_copy1_ax_widgets_prope_idx` (`widgets_property_id`),
    KEY `fk_ax_widgets_has_value_text_ax_widgets1_idx` (`widgets_id`),
    CONSTRAINT `fk_ax_catalog_product_has_value_text_copy1_ax_widgets_property1` FOREIGN KEY (`widgets_property_id`) REFERENCES `ax_widgets_property` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_widgets_has_value_text_ax_widgets1` FOREIGN KEY (`widgets_id`) REFERENCES `ax_widgets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_widgets_has_value_varchar`;
CREATE TABLE `ax_widgets_has_value_varchar`
(
    `id`                  bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `widgets_id`          bigint(20) unsigned NOT NULL,
    `widgets_property_id` bigint(20) unsigned NOT NULL,
    `value`               varchar(500)        NOT NULL,
    `sort`                int(11)          DEFAULT '100',
    `created_at`          int(11) unsigned DEFAULT NULL,
    `updated_at`          int(11) unsigned DEFAULT NULL,
    `deleted_at`          int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`, `widgets_id`, `widgets_property_id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    KEY `fk_ax_catalog_product_has_value_varchar_copy1_ax_widgets_pr_idx` (`widgets_property_id`),
    KEY `fk_ax_widgets_has_value_varchar_ax_widgets1_idx` (`widgets_id`),
    CONSTRAINT `fk_ax_catalog_product_has_value_varchar_copy1_ax_widgets_prop1` FOREIGN KEY (`widgets_property_id`) REFERENCES `ax_widgets_property` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_widgets_has_value_varchar_ax_widgets1` FOREIGN KEY (`widgets_id`) REFERENCES `ax_widgets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_widgets_property`;
CREATE TABLE `ax_widgets_property`
(
    `id`                       bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `widgets_property_type_id` bigint(20) unsigned NOT NULL,
    `title`                    varchar(255)        NOT NULL,
    `description`              varchar(255)     DEFAULT NULL,
    `sort`                     int(11)          DEFAULT NULL,
    `image`                    varchar(255)     DEFAULT NULL,
    `created_at`               int(11) unsigned DEFAULT NULL,
    `updated_at`               int(11) unsigned DEFAULT NULL,
    `deleted_at`               int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`, `widgets_property_type_id`),
    UNIQUE KEY `id_UNIQUE` (`id`),
    UNIQUE KEY `title_UNIQUE` (`title`),
    KEY `fk_ax_widgets_property_ax_widgets_property_type1_idx` (`widgets_property_type_id`),
    CONSTRAINT `fk_ax_widgets_property_ax_widgets_property_type1` FOREIGN KEY (`widgets_property_type_id`) REFERENCES `ax_widgets_property_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_widgets_property_group`;
CREATE TABLE `ax_widgets_property_group`
(
    `id`          bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `title`       varchar(255)        NOT NULL,
    `description` varchar(255)     DEFAULT NULL,
    `sort`        int(11)          DEFAULT NULL,
    `image`       varchar(255)     DEFAULT NULL,
    `created_at`  int(11) unsigned DEFAULT NULL,
    `updated_at`  int(11) unsigned DEFAULT NULL,
    `deleted_at`  int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_widgets_property_has_group`;
CREATE TABLE `ax_widgets_property_has_group`
(
    `widgets_property_id`       bigint(20) unsigned NOT NULL,
    `widgets_property_group_id` bigint(20) unsigned NOT NULL,
    PRIMARY KEY (`widgets_property_id`, `widgets_property_group_id`),
    KEY `fk_ax_widgets_property_has_ax_widgets_property_group_ax_wid_idx` (`widgets_property_group_id`),
    KEY `fk_ax_widgets_property_has_ax_widgets_property_group_ax_wid_idx1` (`widgets_property_id`),
    CONSTRAINT `fk_ax_widgets_property_has_ax_widgets_property_group_ax_widge1` FOREIGN KEY (`widgets_property_id`) REFERENCES `ax_widgets_property` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_widgets_property_has_ax_widgets_property_group_ax_widge2` FOREIGN KEY (`widgets_property_group_id`) REFERENCES `ax_widgets_property_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS `ax_widgets_property_type`;
CREATE TABLE `ax_widgets_property_type`
(
    `id`          bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `resource`    varchar(255)        NOT NULL COMMENT 'Таблица в которой лежит value',
    `title`       varchar(255)        NOT NULL,
    `description` varchar(255)     DEFAULT NULL,
    `sort`        int(11)          DEFAULT NULL,
    `image`       varchar(255)     DEFAULT NULL,
    `created_at`  int(11) unsigned DEFAULT NULL,
    `updated_at`  int(11) unsigned DEFAULT NULL,
    `deleted_at`  int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO `ax_widgets_property_type` (`id`, `resource`, `title`, `description`, `sort`, `image`, `created_at`,
                                        `updated_at`, `deleted_at`)
VALUES (1, 'ax_widgets_has_value_varchar', 'Строка', NULL, 0, NULL, 1651608269, 1651608269, NULL),
       (2, 'ax_widgets_has_value_varchar', 'Ссылка', NULL, 6, NULL, 1651608269, 1651608269, NULL),
       (3, 'ax_widgets_has_value_int', 'Число', NULL, 1, NULL, 1651608269, 1651608269, NULL),
       (4, 'ax_widgets_has_value_decimal', 'Дробное число 0.00', NULL, 2, NULL, 1651608269, 1651608269, NULL),
       (5, 'ax_widgets_has_value_text', 'Большой текст', NULL, 3, NULL, 1651608269, 1651608269, NULL),
       (6, 'ax_widgets_has_value_varchar', 'Файл', NULL, 5, NULL, 1651608269, 1651608269, NULL),
       (7, 'ax_widgets_has_value_varchar', 'Изображение', NULL, 4, NULL, 1651608269, 1651608269, NULL);

DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens`
(
    `id`             bigint(20) unsigned                     NOT NULL AUTO_INCREMENT,
    `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `tokenable_id`   bigint(20) unsigned                     NOT NULL,
    `name`           varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `token`          varchar(64) COLLATE utf8mb4_unicode_ci  NOT NULL,
    `abilities`      text COLLATE utf8mb4_unicode_ci,
    `last_used_at`   timestamp                               NULL DEFAULT NULL,
    `created_at`     timestamp                               NULL DEFAULT NULL,
    `updated_at`     timestamp                               NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
    KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`, `tokenable_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;


-- 2022-05-10 09:35:38
