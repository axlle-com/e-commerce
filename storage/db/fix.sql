DROP TABLE IF EXISTS `a_shop`.`ax_catalog_storage_reserve`;
CREATE TABLE IF NOT EXISTS `a_shop`.`ax_catalog_storage_reserve`
(
    `id`                       BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `catalog_product_id`       BIGINT(20) UNSIGNED NOT NULL,
    `catalog_document_id`      BIGINT(20) UNSIGNED NOT NULL,
    `catalog_storage_place_id` BIGINT(20) UNSIGNED NOT NULL,
    `status`                   TINYINT(1) UNSIGNED NULL DEFAULT 0,
    `in_reserve`               INT UNSIGNED        NULL DEFAULT 0,
    `expired_at`               INT(11) UNSIGNED    NULL,
    `created_at`               INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at`               INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at`               INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`, `catalog_product_id`, `catalog_document_id`, `catalog_storage_place_id`),
    INDEX `fk_ax_catalog_storage_ax_catalog_product1_idx` (`catalog_product_id` ASC),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    INDEX `fk_ax_catalog_storage_reserve_ax_catalog_storage_place1_idx` (`catalog_storage_place_id` ASC),
    INDEX `fk_ax_catalog_storage_reserve_ax_catalog_document1_idx` (`catalog_document_id` ASC),
    CONSTRAINT `fk_ax_catalog_storage_ax_catalog_product10`
        FOREIGN KEY (`catalog_product_id`)
            REFERENCES `a_shop`.`ax_catalog_product` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_storage_reserve_ax_catalog_storage_place1`
        FOREIGN KEY (`catalog_storage_place_id`)
            REFERENCES `a_shop`.`ax_catalog_storage_place` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_storage_reserve_ax_catalog_document1`
        FOREIGN KEY (`catalog_document_id`)
            REFERENCES `a_shop`.`ax_catalog_document` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;

DROP TABLE IF EXISTS `a_shop`.`ax_catalog_document`;
CREATE TABLE IF NOT EXISTS `a_shop`.`ax_catalog_document`
(
    `id`                          BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id`                     BIGINT(20) UNSIGNED NOT NULL,
    `catalog_document_subject_id` BIGINT(20) UNSIGNED NOT NULL,
    `catalog_document_id`         BIGINT(20) UNSIGNED NULL DEFAULT NULL,
    `currency_id`                 BIGINT(20) UNSIGNED NULL,
    `ips_id`                      BIGINT(20) UNSIGNED NULL,
    `status`                      TINYINT(1) UNSIGNED NULL DEFAULT 0,
    `created_at`                  INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at`                  INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at`                  INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`, `user_id`, `catalog_document_subject_id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    INDEX `fk_ax_catalog_document_ax_user1_idx` (`user_id` ASC),
    INDEX `fk_ax_catalog_document_ax_currency1_idx` (`currency_id` ASC),
    INDEX `fk_ax_catalog_document_ax_catalog_document_subject1_idx` (`catalog_document_subject_id` ASC),
    INDEX `fk_ax_catalog_document_ax_ips1_idx` (`ips_id` ASC),
    INDEX `fk_ax_catalog_document_ax_catalog_document1_idx` (`catalog_document_id` ASC),
    CONSTRAINT `fk_ax_catalog_document_ax_user1`
        FOREIGN KEY (`user_id`)
            REFERENCES `a_shop`.`ax_user` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_document_ax_currency1`
        FOREIGN KEY (`currency_id`)
            REFERENCES `a_shop`.`ax_currency` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_document_ax_catalog_document_subject1`
        FOREIGN KEY (`catalog_document_subject_id`)
            REFERENCES `a_shop`.`ax_catalog_document_subject` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_document_ax_ips1`
        FOREIGN KEY (`ips_id`)
            REFERENCES `a_shop`.`ax_ips` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_document_ax_catalog_document1`
        FOREIGN KEY (`catalog_document_id`)
            REFERENCES `a_shop`.`ax_catalog_document` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;


DROP TABLE IF EXISTS `a_shop`.`ax_catalog_document_content`;
CREATE TABLE IF NOT EXISTS `a_shop`.`ax_catalog_document_content`
(
    `id`                  BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `catalog_document_id` BIGINT(20) UNSIGNED NOT NULL,
    `catalog_product_id`  BIGINT(20) UNSIGNED NOT NULL,
    `catalog_storage_id`  BIGINT(20) UNSIGNED NULL,
    `price_in`            DECIMAL UNSIGNED    NULL DEFAULT 0.0,
    `price_out`           DECIMAL UNSIGNED    NULL DEFAULT 0.0,
    `quantity`            INT(11) UNSIGNED    NULL DEFAULT 1,
    `description`         VARCHAR(255)        NULL,
    `created_at`          INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at`          INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at`          INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`, `catalog_document_id`, `catalog_product_id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    INDEX `fk_ax_document_content_ax_catalog_document1_idx` (`catalog_document_id` ASC),
    INDEX `fk_ax_document_content_ax_catalog_product1_idx` (`catalog_product_id` ASC),
    INDEX `fk_ax_catalog_document_content_ax_catalog_storage1_idx` (`catalog_storage_id` ASC),
    CONSTRAINT `fk_ax_document_content_ax_catalog_document1`
        FOREIGN KEY (`catalog_document_id`)
            REFERENCES `a_shop`.`ax_catalog_document` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_document_content_ax_catalog_product1`
        FOREIGN KEY (`catalog_product_id`)
            REFERENCES `a_shop`.`ax_catalog_product` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_document_content_ax_catalog_storage1`
        FOREIGN KEY (`catalog_storage_id`)
            REFERENCES `a_shop`.`ax_catalog_storage` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;

DROP TABLE IF EXISTS `a_shop`.`ax_catalog_order`;
CREATE TABLE IF NOT EXISTS `a_shop`.`ax_catalog_order`
(
    `id`                          BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id`                     BIGINT(20) UNSIGNED NOT NULL,
    `catalog_payment_type_id`     BIGINT(20) UNSIGNED NOT NULL,
    `catalog_delivery_type_id`    BIGINT(20) UNSIGNED NOT NULL,
    `catalog_final_document_id`   BIGINT(20) UNSIGNED NULL DEFAULT NULL,
    `catalog_reserve_document_id` BIGINT(20) UNSIGNED NULL DEFAULT NULL,
    `ips_id`                      BIGINT(20) UNSIGNED NULL DEFAULT NULL,
    `status`                      TINYINT(1) UNSIGNED NULL DEFAULT 0,
    `created_at`                  INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at`                  INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at`                  INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`, `user_id`, `catalog_payment_type_id`, `catalog_delivery_type_id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    INDEX `fk_ax_catalog_order_ax_catalog_payment_type1_idx` (`catalog_payment_type_id` ASC),
    INDEX `fk_ax_catalog_order_ax_catalog_delivery_type1_idx` (`catalog_delivery_type_id` ASC),
    INDEX `fk_ax_catalog_order_ax_catalog_document1_idx` (`catalog_final_document_id` ASC),
    INDEX `fk_ax_catalog_order_ax_user1_idx` (`user_id` ASC),
    INDEX `fk_ax_catalog_order_ax_ips1_idx` (`ips_id` ASC),
    INDEX `fk_ax_catalog_order_ax_catalog_document2_idx` (`catalog_reserve_document_id` ASC),
    CONSTRAINT `fk_ax_catalog_order_ax_catalog_payment_type1`
        FOREIGN KEY (`catalog_payment_type_id`)
            REFERENCES `a_shop`.`ax_catalog_payment_type` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_order_ax_catalog_delivery_type1`
        FOREIGN KEY (`catalog_delivery_type_id`)
            REFERENCES `a_shop`.`ax_catalog_delivery_type` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_order_ax_catalog_document1`
        FOREIGN KEY (`catalog_final_document_id`)
            REFERENCES `a_shop`.`ax_catalog_document` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_order_ax_user1`
        FOREIGN KEY (`user_id`)
            REFERENCES `a_shop`.`ax_user` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_order_ax_ips1`
        FOREIGN KEY (`ips_id`)
            REFERENCES `a_shop`.`ax_ips` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_order_ax_catalog_document2`
        FOREIGN KEY (`catalog_reserve_document_id`)
            REFERENCES `a_shop`.`ax_catalog_document` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;

DROP TABLE IF EXISTS `a_shop`.`ax_user`;
CREATE TABLE IF NOT EXISTS `a_shop`.`ax_user`
(
    `id`                   BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `first_name`           VARCHAR(255)        NOT NULL DEFAULT 'Undefined',
    `last_name`            VARCHAR(255)        NOT NULL DEFAULT 'Undefined',
    `patronymic`           VARCHAR(255)        NULL     DEFAULT NULL,
    `phone`                VARCHAR(255)        NULL,
    `email`                VARCHAR(255)        NULL,
    `is_email`             TINYINT(1) UNSIGNED NULL     DEFAULT 0,
    `is_phone`             TINYINT(1) UNSIGNED NULL     DEFAULT 0,
    `status`               SMALLINT(6)         NOT NULL DEFAULT 0,
    `password_hash`        VARCHAR(255)        NOT NULL,
    `remember_token`       VARCHAR(500)        NULL     DEFAULT NULL,
    `auth_key`             VARCHAR(32)         NULL     DEFAULT NULL,
    `password_reset_token` VARCHAR(255)        NULL     DEFAULT NULL,
    `created_at`           INT(11) UNSIGNED    NULL     DEFAULT NULL,
    `updated_at`           INT(11) UNSIGNED    NULL     DEFAULT NULL,
    `deleted_at`           INT(11) UNSIGNED    NULL     DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `email` (`email` ASC),
    UNIQUE INDEX `password_reset_token` (`password_reset_token` ASC),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    UNIQUE INDEX `phone_UNIQUE` (`phone` ASC)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;

START TRANSACTION;
USE `a_shop`;
INSERT INTO `a_shop`.`ax_user` (`id`, `first_name`, `last_name`, `patronymic`, `phone`, `email`, `is_email`, `is_phone`,
                                `status`, `password_hash`, `remember_token`, `auth_key`, `password_reset_token`,
                                `created_at`, `updated_at`, `deleted_at`)
VALUES (6, 'Алексей', 'Алексеев', 'Александрович', '79621829550', 'axlle@mail.ru', 0, 0, 8,
        '$2y$13$DMqEjJJL9gjftb80gCt5n.fOTyoTfAEv/HsQPh2IEQa42bfNsfF5S', 'kyyBBbb80b3ZflMDdsynKC0B4skxf_gF',
        'kyyBBbb80b3ZflMDdsynKC0B4skxf', NULL, 1651608268, NULL, NULL);

COMMIT;
