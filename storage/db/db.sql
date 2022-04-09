SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE =
    'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

DROP TABLE IF EXISTS `ax_user`;

CREATE TABLE IF NOT EXISTS `ax_user`
(
    `id`                   BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `first_name`           VARCHAR(255)        NOT NULL DEFAULT 'Undefined',
    `last_name`            VARCHAR(255)        NOT NULL DEFAULT 'Undefined',
    `patronymic`           VARCHAR(255)        NOT NULL DEFAULT 'Undefined',
    `email`                VARCHAR(255)        NOT NULL,
    `password_hash`        VARCHAR(255)        NOT NULL,
    `status`               SMALLINT(6)         NOT NULL DEFAULT 0,
    `remember_token`       VARCHAR(500)        NULL     DEFAULT NULL,
    `auth_key`             VARCHAR(32)         NULL     DEFAULT NULL,
    `password_reset_token` VARCHAR(255)        NULL     DEFAULT NULL,
    `verification_token`   VARCHAR(255)        NULL     DEFAULT NULL,
    `created_at`           INT(11) UNSIGNED    NULL     DEFAULT NULL,
    `updated_at`           INT(11) UNSIGNED    NULL     DEFAULT NULL,
    `deleted_at`           INT(11) UNSIGNED    NULL     DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `email` (`email` ASC),
    UNIQUE INDEX `password_reset_token` (`password_reset_token` ASC),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ax_render`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_render`;

CREATE TABLE IF NOT EXISTS `ax_render`
(
    `id`         BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `title`      VARCHAR(255)        NOT NULL,
    `name`       VARCHAR(45)         NOT NULL,
    `resource`   VARCHAR(255)        NULL,
    `created_at` INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at` INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at` INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_gallery`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_gallery`;

CREATE TABLE IF NOT EXISTS `ax_gallery`
(
    `id`          BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `title`       VARCHAR(255)        NULL,
    `description` TEXT                NULL,
    `sort`        INT(11)             NULL DEFAULT 0,
    `image`       VARCHAR(500)        NULL,
    `url`         VARCHAR(255)        NULL,
    `created_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_post_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_post_category`;

CREATE TABLE IF NOT EXISTS `ax_post_category`
(
    `id`                  BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `category_id`         BIGINT(20) UNSIGNED NULL,
    `render_id`           BIGINT(20) UNSIGNED NULL,
    `gallery_id`          BIGINT(20) UNSIGNED NULL,
    `is_published`        TINYINT(1) UNSIGNED NULL DEFAULT 1,
    `is_favourites`       TINYINT(1) UNSIGNED NULL DEFAULT 0,
    `is_watermark`        TINYINT(1)          NULL DEFAULT 1,
    `image`               VARCHAR(255)        NULL DEFAULT NULL,
    `show_image`          TINYINT(1)          NULL DEFAULT 1,
    `url`                 VARCHAR(500)        NOT NULL,
    `alias`               VARCHAR(255)        NOT NULL,
    `title`               VARCHAR(255)        NOT NULL,
    `title_short`         VARCHAR(150)        NULL DEFAULT NULL,
    `description`         TEXT                NULL DEFAULT NULL,
    `preview_description` TEXT                NULL,
    `title_seo`           VARCHAR(255)        NULL DEFAULT NULL,
    `description_seo`     VARCHAR(255)        NULL DEFAULT NULL,
    `sort`                TINYINT(3) UNSIGNED NULL DEFAULT 0,
    `created_at`          INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at`          INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at`          INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    UNIQUE INDEX `alias_UNIQUE` (`alias` ASC),
    INDEX `fk_ax_post_category_ax_render1_idx` (`render_id` ASC),
    UNIQUE INDEX `url_UNIQUE` (`url` ASC),
    INDEX `fk_ax_post_category_ax_post_category1_idx` (`category_id` ASC),
    INDEX `fk_ax_post_category_ax_gallery1_idx` (`gallery_id` ASC),
    CONSTRAINT `fk_ax_post_category_ax_render1`
        FOREIGN KEY (`render_id`)
            REFERENCES `ax_render` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_post_category_ax_post_category1`
        FOREIGN KEY (`category_id`)
            REFERENCES `ax_post_category` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_post_category_ax_gallery1`
        FOREIGN KEY (`gallery_id`)
            REFERENCES `ax_gallery` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ax_post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_post`;

CREATE TABLE IF NOT EXISTS `ax_post`
(
    `id`                  BIGINT(20) UNSIGNED  NOT NULL AUTO_INCREMENT,
    `user_id`             BIGINT(20) UNSIGNED  NOT NULL,
    `render_id`           BIGINT(20) UNSIGNED  NULL,
    `category_id`         BIGINT(20) UNSIGNED  NULL,
    `is_published`        TINYINT(1) UNSIGNED  NULL DEFAULT 1,
    `is_favourites`       TINYINT(1) UNSIGNED  NULL DEFAULT 0,
    `is_comments`         TINYINT(1) UNSIGNED  NULL DEFAULT 0,
    `is_image_post`       TINYINT(1) UNSIGNED  NULL DEFAULT 1,
    `is_image_category`   TINYINT(1) UNSIGNED  NULL DEFAULT 1,
    `is_watermark`        TINYINT(1) UNSIGNED  NULL DEFAULT 1,
    `media`               VARCHAR(255)         NULL DEFAULT NULL,
    `url`                 VARCHAR(500)         NOT NULL,
    `alias`               VARCHAR(255)         NOT NULL,
    `title`               VARCHAR(255)         NOT NULL,
    `title_short`         VARCHAR(155)         NULL DEFAULT NULL,
    `preview_description` TEXT                 NULL DEFAULT NULL,
    `description`         TEXT                 NULL DEFAULT NULL,
    `title_seo`           VARCHAR(255)         NULL DEFAULT NULL,
    `description_seo`     VARCHAR(255)         NULL DEFAULT NULL,
    `show_date`           TINYINT(1)           NULL DEFAULT 1,
    `date_pub`            INT(11)              NULL DEFAULT 0,
    `date_end`            INT(11)              NULL DEFAULT 0,
    `control_date_pub`    TINYINT(1)           NULL DEFAULT 0,
    `control_date_end`    TINYINT(1)           NULL DEFAULT 0,
    `image`               VARCHAR(255)         NULL DEFAULT NULL,
    `hits`                INT(11) UNSIGNED     NULL DEFAULT 0,
    `sort`                INT(11)              NULL DEFAULT 0,
    `stars`               FLOAT(1, 1) UNSIGNED NULL DEFAULT '0.0',
    `created_at`          INT(11) UNSIGNED     NULL DEFAULT NULL,
    `updated_at`          INT(11) UNSIGNED     NULL DEFAULT NULL,
    `deleted_at`          INT(11) UNSIGNED     NULL DEFAULT NULL,
    PRIMARY KEY (`id`, `user_id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    UNIQUE INDEX `alias_UNIQUE` (`alias` ASC),
    INDEX `fk_ax_post_ax_user1_idx` (`user_id` ASC),
    INDEX `fk_ax_post_ax_render1_idx` (`render_id` ASC),
    INDEX `fk_ax_post_ax_post_category1_idx` (`category_id` ASC),
    UNIQUE INDEX `url_UNIQUE` (`url` ASC),
    CONSTRAINT `fk_ax_post_ax_user1`
        FOREIGN KEY (`user_id`)
            REFERENCES `ax_user` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_post_ax_render1`
        FOREIGN KEY (`render_id`)
            REFERENCES `ax_render` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_post_ax_post_category1`
        FOREIGN KEY (`category_id`)
            REFERENCES `ax_post_category` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ax_ips`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_ips`;

CREATE TABLE IF NOT EXISTS `ax_ips`
(
    `id`         BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `ip`         VARCHAR(255)        NOT NULL,
    `status`     TINYINT(1)          NULL DEFAULT 1,
    `created_at` INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at` INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at` INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    UNIQUE INDEX `ip_UNIQUE` (`ip` ASC)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_comments`;

CREATE TABLE IF NOT EXISTS `ax_comments`
(
    `id`          BIGINT(20) UNSIGNED NOT NULL,
    `resource`    VARCHAR(255)        NOT NULL,
    `resource_id` BIGINT(20) UNSIGNED NOT NULL,
    `person`      VARCHAR(255)        NOT NULL,
    `person_id`   BIGINT(20)          NOT NULL,
    `comments_id` BIGINT(20) UNSIGNED NULL,
    `ips_id`      BIGINT(20) UNSIGNED NULL,
    `status`      TINYINT(1) UNSIGNED NULL DEFAULT 0,
    `is_viewed`   TINYINT(1)          NULL DEFAULT 0,
    `text`        TEXT                NOT NULL,
    `created_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`, `resource`, `resource_id`, `person_id`, `person`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    INDEX `fk_ax_post_comments_ax_post_comments1_idx` (`comments_id` ASC),
    INDEX `fk_ax_post_comments_ax_ips1_idx` (`ips_id` ASC),
    CONSTRAINT `fk_ax_post_comments_ax_post_comments1`
        FOREIGN KEY (`comments_id`)
            REFERENCES `ax_comments` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_post_comments_ax_ips1`
        FOREIGN KEY (`ips_id`)
            REFERENCES `ax_ips` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_widgets`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_widgets`;

CREATE TABLE IF NOT EXISTS `ax_widgets`
(
    `id`          BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name`        VARCHAR(255)        NOT NULL,
    `title`       VARCHAR(255)        NOT NULL,
    `description` VARCHAR(255)        NULL,
    `created_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    UNIQUE INDEX `name_UNIQUE` (`name` ASC)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_tags`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_tags`;

CREATE TABLE IF NOT EXISTS `ax_tags`
(
    `id`              BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `is_sitemap`      TINYINT(1)          NULL DEFAULT 1,
    `is_published`    TINYINT(1) UNSIGNED NULL DEFAULT 1,
    `is_favourites`   TINYINT(1) UNSIGNED NULL DEFAULT 0,
    `is_watermark`    TINYINT(1)          NULL DEFAULT 1,
    `image`           VARCHAR(255)        NULL DEFAULT NULL,
    `show_image`      TINYINT(1)          NULL DEFAULT 1,
    `alias`           VARCHAR(255)        NOT NULL,
    `title`           VARCHAR(255)        NOT NULL,
    `title_short`     VARCHAR(150)        NULL DEFAULT NULL,
    `description`     TEXT                NULL DEFAULT NULL,
    `title_seo`       VARCHAR(255)        NULL DEFAULT NULL,
    `description_seo` VARCHAR(255)        NULL DEFAULT NULL,
    `sort`            TINYINT(3) UNSIGNED NULL DEFAULT 0,
    `created_at`      INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at`      INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at`      INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    UNIQUE INDEX `title_UNIQUE` (`title` ASC),
    UNIQUE INDEX `alias_UNIQUE` (`alias` ASC)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ax_gallery_image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_gallery_image`;

CREATE TABLE IF NOT EXISTS `ax_gallery_image`
(
    `id`          BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `gallery_id`  BIGINT(20) UNSIGNED NOT NULL,
    `url`         VARCHAR(255)        NOT NULL,
    `title`       VARCHAR(255)        NULL,
    `description` TEXT                NULL,
    `sort`        INT(11)             NULL DEFAULT 0,
    `created_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`, `gallery_id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    UNIQUE INDEX `href_UNIQUE` (`url` ASC),
    INDEX `fk_ax_gallery_image_ax_gallery1_idx` (`gallery_id` ASC),
    CONSTRAINT `fk_ax_gallery_image_ax_gallery1`
        FOREIGN KEY (`gallery_id`)
            REFERENCES `ax_gallery` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_info_block`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_info_block`;

CREATE TABLE IF NOT EXISTS `ax_info_block`
(
    `id`               BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `render_id`        BIGINT(20) UNSIGNED NULL,
    `gallery_id`       BIGINT(20) UNSIGNED NULL,
    `is_published`     TINYINT(1) UNSIGNED NULL DEFAULT 1,
    `is_favourites`    TINYINT(1) UNSIGNED NULL DEFAULT 0,
    `is_watermark`     TINYINT(1)          NULL DEFAULT 1,
    `show_image`       TINYINT(1)          NULL DEFAULT 1,
    `media`            VARCHAR(255)        NULL DEFAULT NULL,
    `alias`            VARCHAR(255)        NOT NULL,
    `title`            VARCHAR(255)        NOT NULL,
    `title_short`      VARCHAR(155)        NULL DEFAULT NULL,
    `description`      TEXT                NULL DEFAULT NULL,
    `show_date`        TINYINT(1)          NULL DEFAULT 1,
    `date_pub`         INT(11)             NULL DEFAULT 0,
    `date_end`         INT(11)             NULL DEFAULT 0,
    `control_date_pub` TINYINT(1)          NULL DEFAULT 0,
    `control_date_end` TINYINT(1)          NULL DEFAULT 0,
    `image`            VARCHAR(255)        NULL DEFAULT NULL,
    `sort`             INT(11)             NULL DEFAULT 0,
    `created_at`       INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at`       INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at`       INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    UNIQUE INDEX `title_UNIQUE` (`title` ASC),
    UNIQUE INDEX `alias_UNIQUE` (`alias` ASC),
    INDEX `fk_ax_infoblock_ax_render1_idx` (`render_id` ASC),
    INDEX `fk_ax_info_block_ax_gallery1_idx` (`gallery_id` ASC),
    CONSTRAINT `fk_ax_infoblock_ax_render1`
        FOREIGN KEY (`render_id`)
            REFERENCES `ax_render` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_info_block_ax_gallery1`
        FOREIGN KEY (`gallery_id`)
            REFERENCES `ax_gallery` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ax_tags_has_resource`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_tags_has_resource`;

CREATE TABLE IF NOT EXISTS `ax_tags_has_resource`
(
    `tags_id`     BIGINT(20) UNSIGNED NOT NULL,
    `resource`    VARCHAR(255)        NOT NULL,
    `resource_id` BIGINT(20) UNSIGNED NOT NULL,
    PRIMARY KEY (`tags_id`, `resource`, `resource_id`),
    INDEX `fk_ax_post_has_ax_post_tags_ax_post_tags1_idx` (`tags_id` ASC),
    CONSTRAINT `fk_ax_post_has_ax_post_tags_ax_post_tags1`
        FOREIGN KEY (`tags_id`)
            REFERENCES `ax_tags` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ax_menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_menu`;

CREATE TABLE IF NOT EXISTS `ax_menu`
(
    `id`          BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `title`       VARCHAR(255)        NOT NULL,
    `name`        VARCHAR(45)         NOT NULL,
    `description` VARCHAR(255)        NULL,
    `created_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    UNIQUE INDEX `title_UNIQUE` (`title` ASC),
    UNIQUE INDEX `name_UNIQUE` (`name` ASC)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_menu_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_menu_item`;

CREATE TABLE IF NOT EXISTS `ax_menu_item`
(
    `id`           BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `menu_id`      BIGINT(20) UNSIGNED NOT NULL,
    `menu_item_id` BIGINT(20) UNSIGNED NULL,
    `resource`     VARCHAR(255)        NULL,
    `resource_id`  BIGINT(20) UNSIGNED NULL,
    `title`        VARCHAR(255)        NOT NULL,
    `sort`         INT(11)             NULL DEFAULT 0,
    `url`          VARCHAR(255)        NOT NULL,
    `created_at`   INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at`   INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at`   INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`, `menu_id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    INDEX `fk_ax_menu_item_ax_menu1_idx` (`menu_id` ASC),
    INDEX `fk_ax_menu_item_ax_menu_item1_idx` (`menu_item_id` ASC),
    CONSTRAINT `fk_ax_menu_item_ax_menu1`
        FOREIGN KEY (`menu_id`)
            REFERENCES `ax_menu` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_menu_item_ax_menu_item1`
        FOREIGN KEY (`menu_item_id`)
            REFERENCES `ax_menu_item` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_settings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_settings`;

CREATE TABLE IF NOT EXISTS `ax_settings`
(
    `id`                  BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `script`              LONGTEXT            NULL,
    `css`                 LONGTEXT            NULL,
    `robots`              TEXT                NULL,
    `google_verification` VARCHAR(255)        NULL,
    `yandex_verification` VARCHAR(255)        NULL,
    `yandex_metrika`      TEXT                NULL,
    `google_analytics`    TEXT                NULL,
    `logo_general`        VARCHAR(255)        NULL,
    `logo_second`         VARCHAR(255)        NULL,
    `company_name`        VARCHAR(255)        NULL,
    `company_name_full`   VARCHAR(500)        NULL,
    `company_phone`       VARCHAR(255)        NULL,
    `company_email`       VARCHAR(500)        NULL,
    `company_address`     VARCHAR(500)        NULL,
    `redirect_on`         TINYINT(1) UNSIGNED NULL DEFAULT 1,
    `created_at`          INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at`          INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at`          INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_user_guest`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_user_guest`;

CREATE TABLE IF NOT EXISTS `ax_user_guest`
(
    `id`         BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `email`      VARCHAR(255)        NOT NULL,
    `name`       VARCHAR(255)        NULL,
    `created_at` INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at` INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at` INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    UNIQUE INDEX `email_UNIQUE` (`email` ASC)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_letters`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_letters`;

CREATE TABLE IF NOT EXISTS `ax_letters`
(
    `id`          BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `resource`    VARCHAR(255)        NOT NULL,
    `resource_id` BIGINT(20) UNSIGNED NOT NULL,
    `person`      VARCHAR(255)        NOT NULL,
    `person_id`   BIGINT(20)          NOT NULL,
    `ips_id`      BIGINT(20) UNSIGNED NULL,
    `subject`     VARCHAR(255)        NULL,
    `text`        TEXT                NULL,
    `is_viewed`   TINYINT(1)          NULL DEFAULT 0,
    `created_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`, `resource`, `resource_id`, `person`, `person_id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    INDEX `fk_ax_letters_ax_ips1_idx` (`ips_id` ASC),
    CONSTRAINT `fk_ax_letters_ax_ips1`
        FOREIGN KEY (`ips_id`)
            REFERENCES `ax_ips` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_ips_has_resource`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_ips_has_resource`;

CREATE TABLE IF NOT EXISTS `ax_ips_has_resource`
(
    `ips_id`      BIGINT(20) UNSIGNED NOT NULL,
    `resource`    VARCHAR(255)        NOT NULL,
    `resource_id` BIGINT(20) UNSIGNED NOT NULL,
    PRIMARY KEY (`ips_id`, `resource`, `resource_id`),
    INDEX `fk_ax_ips_has_ax_visitors_ax_ips1_idx` (`ips_id` ASC),
    CONSTRAINT `fk_ax_ips_has_ax_visitors_ax_ips1`
        FOREIGN KEY (`ips_id`)
            REFERENCES `ax_ips` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_widgets_has_resource`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_widgets_has_resource`;

CREATE TABLE IF NOT EXISTS `ax_widgets_has_resource`
(
    `widgets_id`  BIGINT(20) UNSIGNED NOT NULL,
    `resource`    VARCHAR(255)        NOT NULL,
    `resource_id` BIGINT(20) UNSIGNED NOT NULL,
    PRIMARY KEY (`widgets_id`, `resource`, `resource_id`),
    INDEX `fk_ax_post_has_ax_widgets_ax_widgets1_idx` (`widgets_id` ASC),
    CONSTRAINT `fk_ax_post_has_ax_widgets_ax_widgets1`
        FOREIGN KEY (`widgets_id`)
            REFERENCES `ax_widgets` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ax_redirect`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_redirect`;

CREATE TABLE IF NOT EXISTS `ax_redirect`
(
    `id`         BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `url`        VARCHAR(500)        NOT NULL,
    `url_old`    VARCHAR(500)        NOT NULL,
    `created_at` INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at` INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at` INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_menu_has_resource`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_menu_has_resource`;

CREATE TABLE IF NOT EXISTS `ax_menu_has_resource`
(
    `menu_id`     BIGINT(20) UNSIGNED NOT NULL,
    `resource`    VARCHAR(255)        NOT NULL,
    `resource_id` BIGINT(20) UNSIGNED NOT NULL,
    PRIMARY KEY (`menu_id`, `resource`, `resource_id`),
    INDEX `fk_ax_menu_has_ax_post_category_ax_menu1_idx` (`menu_id` ASC),
    CONSTRAINT `fk_ax_menu_has_ax_post_category_ax_menu10`
        FOREIGN KEY (`menu_id`)
            REFERENCES `ax_menu` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_info_block_has_resource`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_info_block_has_resource`;

CREATE TABLE IF NOT EXISTS `ax_info_block_has_resource`
(
    `info_block_id` BIGINT(20) UNSIGNED NOT NULL,
    `resource`      VARCHAR(255)        NOT NULL,
    `resource_id`   BIGINT(20) UNSIGNED NOT NULL,
    PRIMARY KEY (`info_block_id`, `resource`, `resource_id`),
    INDEX `fk_ax_infoblock_has_resource_ax_info_block1_idx` (`info_block_id` ASC),
    CONSTRAINT `fk_ax_infoblock_has_resource_ax_info_block1`
        FOREIGN KEY (`info_block_id`)
            REFERENCES `ax_info_block` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_user_token`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_user_token`;

CREATE TABLE IF NOT EXISTS `ax_user_token`
(
    `id`         BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id`    BIGINT(20) UNSIGNED NOT NULL,
    `type`       VARCHAR(45)         NOT NULL,
    `token`      VARCHAR(800)        NOT NULL,
    `created_at` INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at` INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at` INT(11) UNSIGNED    NULL DEFAULT NULL,
    `expired_at` INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`, `user_id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    INDEX `fk_table1_ax_user1_idx` (`user_id` ASC),
    UNIQUE INDEX `value_UNIQUE` (`token` ASC),
    CONSTRAINT `fk_table1_ax_user1`
        FOREIGN KEY (`user_id`)
            REFERENCES `ax_user` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_gallery_has_resource`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_gallery_has_resource`;

CREATE TABLE IF NOT EXISTS `ax_gallery_has_resource`
(
    `gallery_id`  BIGINT(20) UNSIGNED NOT NULL,
    `resource`    VARCHAR(255)        NOT NULL,
    `resource_id` BIGINT(20) UNSIGNED NOT NULL,
    PRIMARY KEY (`gallery_id`, `resource`, `resource_id`),
    INDEX `fk_ax_gallery_has_resource_ax_gallery1_idx` (`gallery_id` ASC),
    CONSTRAINT `fk_ax_gallery_has_resource_ax_gallery1`
        FOREIGN KEY (`gallery_id`)
            REFERENCES `ax_gallery` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ax_phone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_phone`;

CREATE TABLE IF NOT EXISTS `ax_phone`
(
    `id`         BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `number`     VARCHAR(45)         NOT NULL,
    `created_at` INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at` INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at` INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    UNIQUE INDEX `number_UNIQUE` (`number` ASC)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_phone_has_resource`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_phone_has_resource`;

CREATE TABLE IF NOT EXISTS `ax_phone_has_resource`
(
    `phone_id`    BIGINT(20) UNSIGNED NOT NULL,
    `resource`    VARCHAR(255)        NOT NULL,
    `resource_id` BIGINT(20) UNSIGNED NOT NULL,
    PRIMARY KEY (`phone_id`, `resource`, `resource_id`),
    INDEX `fk_ax_phone_has_resource_ax_phone1_idx` (`phone_id` ASC),
    CONSTRAINT `fk_ax_phone_has_resource_ax_phone1`
        FOREIGN KEY (`phone_id`)
            REFERENCES `ax_phone` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_migrations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_migrations`;

CREATE TABLE IF NOT EXISTS `ax_migrations`
(
    `id`        BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `migration` VARCHAR(255)        NOT NULL,
    `batch`     INT(11)             NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_catalog_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_catalog_category`;

CREATE TABLE IF NOT EXISTS `ax_catalog_category`
(
    `id`                  BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `category_id`         BIGINT(20) UNSIGNED NULL,
    `render_id`           BIGINT(20) UNSIGNED NULL,
    `gallery_id`          BIGINT(20) UNSIGNED NULL,
    `is_published`        TINYINT(1) UNSIGNED NULL DEFAULT 1,
    `is_favourites`       TINYINT(1) UNSIGNED NULL DEFAULT 0,
    `is_watermark`        TINYINT(1)          NULL DEFAULT 1,
    `image`               VARCHAR(255)        NULL DEFAULT NULL,
    `show_image`          TINYINT(1)          NULL DEFAULT 1,
    `url`                 VARCHAR(500)        NOT NULL,
    `alias`               VARCHAR(255)        NOT NULL,
    `title`               VARCHAR(255)        NOT NULL,
    `title_short`         VARCHAR(150)        NULL DEFAULT NULL,
    `description`         TEXT                NULL DEFAULT NULL,
    `preview_description` TEXT                NULL,
    `title_seo`           VARCHAR(255)        NULL DEFAULT NULL,
    `description_seo`     VARCHAR(255)        NULL DEFAULT NULL,
    `sort`                INT(11) UNSIGNED    NULL DEFAULT 0,
    `created_at`          INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at`          INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at`          INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    INDEX `fk_ax_catalog_category_ax_catalog_category1_idx` (`category_id` ASC),
    UNIQUE INDEX `url_UNIQUE` (`url` ASC),
    UNIQUE INDEX `alias_UNIQUE` (`alias` ASC),
    INDEX `fk_ax_catalog_category_ax_render1_idx` (`render_id` ASC),
    INDEX `fk_ax_catalog_category_ax_gallery1_idx` (`gallery_id` ASC),
    CONSTRAINT `fk_ax_catalog_category_ax_catalog_category1`
        FOREIGN KEY (`category_id`)
            REFERENCES `ax_catalog_category` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_category_ax_render1`
        FOREIGN KEY (`render_id`)
            REFERENCES `ax_render` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_category_ax_gallery1`
        FOREIGN KEY (`gallery_id`)
            REFERENCES `ax_gallery` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_catalog_product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_catalog_product`;

CREATE TABLE IF NOT EXISTS `ax_catalog_product`
(
    `id`                  BIGINT(20) UNSIGNED  NOT NULL AUTO_INCREMENT,
    `category_id`         BIGINT(20) UNSIGNED  NULL,
    `render_id`           BIGINT(20) UNSIGNED  NULL,
    `is_published`        TINYINT(1) UNSIGNED  NULL DEFAULT 1,
    `is_favourites`       TINYINT(1) UNSIGNED  NULL DEFAULT 0,
    `is_comments`         TINYINT(1) UNSIGNED  NULL DEFAULT 0,
    `is_watermark`        TINYINT(1) UNSIGNED  NULL DEFAULT 1,
    `media`               VARCHAR(255)         NULL DEFAULT NULL,
    `url`                 VARCHAR(500)         NOT NULL,
    `alias`               VARCHAR(255)         NOT NULL,
    `title`               VARCHAR(255)         NOT NULL,
    `price`               FLOAT                NULL DEFAULT 0.0,
    `title_short`         VARCHAR(155)         NULL DEFAULT NULL,
    `preview_description` TEXT                 NULL DEFAULT NULL,
    `description`         TEXT                 NULL DEFAULT NULL,
    `title_seo`           VARCHAR(255)         NULL DEFAULT NULL,
    `description_seo`     VARCHAR(255)         NULL DEFAULT NULL,
    `show_date`           TINYINT(1)           NULL DEFAULT 1,
    `image`               VARCHAR(255)         NULL DEFAULT NULL,
    `hits`                INT(11) UNSIGNED     NULL DEFAULT 0,
    `sort`                INT(11)              NULL DEFAULT 0,
    `stars`               FLOAT(1, 1) UNSIGNED NULL DEFAULT '0.0',
    `created_at`          INT(11) UNSIGNED     NULL DEFAULT NULL,
    `updated_at`          INT(11) UNSIGNED     NULL DEFAULT NULL,
    `deleted_at`          INT(11) UNSIGNED     NULL DEFAULT NULL,
    UNIQUE INDEX `url_UNIQUE` (`url` ASC),
    UNIQUE INDEX `alias_UNIQUE` (`alias` ASC),
    PRIMARY KEY (`id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    INDEX `fk_ax_catalog_product_ax_render1_idx` (`render_id` ASC),
    INDEX `fk_ax_catalog_product_ax_catalog_category1_idx` (`category_id` ASC),
    CONSTRAINT `fk_ax_catalog_product_ax_render1`
        FOREIGN KEY (`render_id`)
            REFERENCES `ax_render` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_product_ax_catalog_category1`
        FOREIGN KEY (`category_id`)
            REFERENCES `ax_catalog_category` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_catalog_property`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_catalog_property`;

CREATE TABLE IF NOT EXISTS `ax_catalog_property`
(
    `id`          BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `title`       VARCHAR(255)        NOT NULL,
    `description` VARCHAR(255)        NULL,
    `sort`        INT(11)             NULL,
    `image`       VARCHAR(255)        NULL DEFAULT NULL,
    `created_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_catalog_property_value`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_catalog_property_value`;

CREATE TABLE IF NOT EXISTS `ax_catalog_property_value`
(
    `id`          BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `property_id` BIGINT(20) UNSIGNED NOT NULL,
    `value`       VARCHAR(500)        NOT NULL,
    `created_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    PRIMARY KEY (`id`, `property_id`),
    INDEX `fk_ax_catalog_property_value_ax_catalog_property1_idx` (`property_id` ASC),
    CONSTRAINT `fk_ax_catalog_property_value_ax_catalog_property1`
        FOREIGN KEY (`property_id`)
            REFERENCES `ax_catalog_property` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_catalog_property_has_resource`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_catalog_property_has_resource`;

CREATE TABLE IF NOT EXISTS `ax_catalog_property_has_resource`
(
    `property_id` BIGINT(20) UNSIGNED NOT NULL,
    `resource_id` BIGINT(20) UNSIGNED NOT NULL,
    `resource`    VARCHAR(255)        NOT NULL,
    PRIMARY KEY (`property_id`, `resource_id`, `resource`),
    INDEX `fk_ax_tags_has_resource_copy1_ax_catalog_property1_idx` (`property_id` ASC),
    CONSTRAINT `fk_ax_tags_has_resource_copy1_ax_catalog_property1`
        FOREIGN KEY (`property_id`)
            REFERENCES `ax_catalog_property` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ax_currency`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_currency`;

CREATE TABLE IF NOT EXISTS `ax_currency`
(
    `id`         BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `global_id`  VARCHAR(50)         NOT NULL,
    `num_code`   INT                 NOT NULL,
    `char_code`  VARCHAR(45)         NOT NULL,
    `title`      VARCHAR(500)        NOT NULL,
    `created_at` INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at` INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at` INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`, `global_id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    UNIQUE INDEX `num_code_UNIQUE` (`num_code` ASC),
    UNIQUE INDEX `char_code_UNIQUE` (`char_code` ASC),
    UNIQUE INDEX `global_id_UNIQUE` (`global_id` ASC)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_catalog_document_subject`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_catalog_document_subject`;

CREATE TABLE IF NOT EXISTS `ax_catalog_document_subject`
(
    `id`         BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name`       VARCHAR(45)         NOT NULL,
    `title`      VARCHAR(500)        NOT NULL,
    `created_at` INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at` INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at` INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `name_UNIQUE` (`name` ASC)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_catalog_document`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_catalog_document`;

CREATE TABLE IF NOT EXISTS `ax_catalog_document`
(
    `id`                          BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id`                     BIGINT(20) UNSIGNED NOT NULL,
    `catalog_document_subject_id` BIGINT(20) UNSIGNED NOT NULL,
    `currency_id`                 BIGINT(20) UNSIGNED NULL,
    `ips_id`                      BIGINT(20) UNSIGNED NULL,
    `type`                        VARCHAR(45)         NOT NULL,
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
    CONSTRAINT `fk_ax_catalog_document_ax_user1`
        FOREIGN KEY (`user_id`)
            REFERENCES `ax_user` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_document_ax_currency1`
        FOREIGN KEY (`currency_id`)
            REFERENCES `ax_currency` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_document_ax_catalog_document_subject1`
        FOREIGN KEY (`catalog_document_subject_id`)
            REFERENCES `ax_catalog_document_subject` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_document_ax_ips1`
        FOREIGN KEY (`ips_id`)
            REFERENCES `ax_ips` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_catalog_basket`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_catalog_basket`;

CREATE TABLE IF NOT EXISTS `ax_catalog_basket`
(
    `id`               BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id`          BIGINT(20) UNSIGNED NOT NULL,
    `product_id`       BIGINT(20) UNSIGNED NOT NULL,
    `catalog_order_id` BIGINT(20) UNSIGNED NULL,
    `currency_id`      BIGINT(20) UNSIGNED NULL,
    `ips_id`           BIGINT(20) UNSIGNED NULL,
    `quantity`         INT(11)             NULL,
    `status`           TINYINT(1) UNSIGNED NULL DEFAULT 0,
    `created_at`       INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at`       INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at`       INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`, `user_id`, `product_id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    INDEX `fk_ax_catalog_basket_ax_catalog_product1_idx` (`product_id` ASC),
    INDEX `fk_ax_catalog_basket_ax_user1_idx` (`user_id` ASC),
    INDEX `fk_ax_catalog_basket_ax_ips1_idx` (`ips_id` ASC),
    INDEX `fk_ax_catalog_basket_ax_currency1_idx` (`currency_id` ASC),
    INDEX `fk_ax_catalog_basket_ax_catalog_order1_idx` (`catalog_order_id` ASC),
    CONSTRAINT `fk_ax_catalog_basket_ax_catalog_product1`
        FOREIGN KEY (`product_id`)
            REFERENCES `ax_catalog_product` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_basket_ax_user1`
        FOREIGN KEY (`user_id`)
            REFERENCES `ax_user` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_basket_ax_ips1`
        FOREIGN KEY (`ips_id`)
            REFERENCES `ax_ips` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_basket_ax_currency1`
        FOREIGN KEY (`currency_id`)
            REFERENCES `ax_currency` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_basket_ax_catalog_order1`
        FOREIGN KEY (`catalog_order_id`)
            REFERENCES `ax_catalog_document` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_currency_exchange_rate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_currency_exchange_rate`;

CREATE TABLE IF NOT EXISTS `ax_currency_exchange_rate`
(
    `id`          BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `currency_id` BIGINT(20) UNSIGNED NOT NULL,
    `value`       FLOAT               NOT NULL,
    `date_rate`   INT(11) UNSIGNED    NOT NULL,
    `created_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`, `currency_id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    INDEX `fk_ax_currency_exchange_rate_ax_currency1_idx` (`currency_id` ASC),
    CONSTRAINT `fk_ax_currency_exchange_rate_ax_currency1`
        FOREIGN KEY (`currency_id`)
            REFERENCES `ax_currency` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_catalog_product_has_currency`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_catalog_product_has_currency`;

CREATE TABLE IF NOT EXISTS `ax_catalog_product_has_currency`
(
    `catalog_product_id` BIGINT(20) UNSIGNED NOT NULL,
    `currency_id`        BIGINT(20) UNSIGNED NOT NULL,
    `amount`             FLOAT UNSIGNED      NOT NULL DEFAULT 0.0,
    `date_rate`          INT(11) UNSIGNED    NOT NULL,
    PRIMARY KEY (`catalog_product_id`, `currency_id`),
    INDEX `fk_ax_catalog_product_has_ax_currency_ax_currency1_idx` (`currency_id` ASC),
    INDEX `fk_ax_catalog_product_has_ax_currency_ax_catalog_product1_idx` (`catalog_product_id` ASC),
    CONSTRAINT `fk_ax_catalog_product_has_ax_currency_ax_catalog_product1`
        FOREIGN KEY (`catalog_product_id`)
            REFERENCES `ax_catalog_product` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_product_has_ax_currency_ax_currency1`
        FOREIGN KEY (`currency_id`)
            REFERENCES `ax_currency` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_catalog_storage_place`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_catalog_storage_place`;

CREATE TABLE IF NOT EXISTS `ax_catalog_storage_place`
(
    `id`                       BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `catalog_storage_place_id` BIGINT(20) UNSIGNED NULL,
    `is_place`                 TINYINT(1)          NOT NULL DEFAULT 0,
    `title`                    VARCHAR(500)        NOT NULL,
    `created_at`               INT(11) UNSIGNED    NULL     DEFAULT NULL,
    `updated_at`               INT(11) UNSIGNED    NULL     DEFAULT NULL,
    `deleted_at`               INT(11) UNSIGNED    NULL     DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    INDEX `fk_ax_catalog_storage_place_ax_catalog_storage_place1_idx` (`catalog_storage_place_id` ASC),
    CONSTRAINT `fk_ax_catalog_storage_place_ax_catalog_storage_place1`
        FOREIGN KEY (`catalog_storage_place_id`)
            REFERENCES `ax_catalog_storage_place` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_catalog_document_content`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_catalog_document_content`;

CREATE TABLE IF NOT EXISTS `ax_catalog_document_content`
(
    `id`                       BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `catalog_document_id`      BIGINT(20) UNSIGNED NOT NULL,
    `catalog_product_id`       BIGINT(20) UNSIGNED NOT NULL,
    `catalog_storage_place_id` BIGINT(20) UNSIGNED NULL,
    PRIMARY KEY (`id`, `catalog_document_id`, `catalog_product_id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    INDEX `fk_ax_document_content_ax_catalog_document1_idx` (`catalog_document_id` ASC),
    INDEX `fk_ax_document_content_ax_catalog_product1_idx` (`catalog_product_id` ASC),
    INDEX `fk_ax_catalog_document_content_ax_catalog_storage_place1_idx` (`catalog_storage_place_id` ASC),
    CONSTRAINT `fk_ax_document_content_ax_catalog_document1`
        FOREIGN KEY (`catalog_document_id`)
            REFERENCES `ax_catalog_document` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_document_content_ax_catalog_product1`
        FOREIGN KEY (`catalog_product_id`)
            REFERENCES `ax_catalog_product` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_document_content_ax_catalog_storage_place1`
        FOREIGN KEY (`catalog_storage_place_id`)
            REFERENCES `ax_catalog_storage_place` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_wallet_currency`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_wallet_currency`;

CREATE TABLE IF NOT EXISTS `ax_wallet_currency`
(
    `id`          BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `currency_id` BIGINT(20) UNSIGNED NOT NULL,
    `name`        VARCHAR(50)         NOT NULL,
    `title`       VARCHAR(45)         NOT NULL,
    `is_national` TINYINT(1) UNSIGNED NOT NULL,
    `created_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`, `currency_id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    INDEX `fk_ax_wallet_currency_ax_currency1_idx` (`currency_id` ASC),
    CONSTRAINT `fk_ax_wallet_currency_ax_currency1`
        FOREIGN KEY (`currency_id`)
            REFERENCES `ax_currency` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_wallet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_wallet`;

CREATE TABLE IF NOT EXISTS `ax_wallet`
(
    `id`                 BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id`            BIGINT(20) UNSIGNED NOT NULL,
    `wallet_currency_id` BIGINT(20) UNSIGNED NOT NULL,
    `balance`            FLOAT UNSIGNED      NULL DEFAULT 0.0,
    `created_at`         INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at`         INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at`         INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`, `user_id`, `wallet_currency_id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    INDEX `fk_ax_wallet_ax_user1_idx` (`user_id` ASC),
    INDEX `fk_ax_wallet_ax_wallet_currency1_idx` (`wallet_currency_id` ASC),
    CONSTRAINT `fk_ax_wallet_ax_user1`
        FOREIGN KEY (`user_id`)
            REFERENCES `ax_user` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_wallet_ax_wallet_currency1`
        FOREIGN KEY (`wallet_currency_id`)
            REFERENCES `ax_wallet_currency` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_wallet_transaction_subject`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_wallet_transaction_subject`;

CREATE TABLE IF NOT EXISTS `ax_wallet_transaction_subject`
(
    `id`         BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name`       VARCHAR(45)         NOT NULL,
    `title`      VARCHAR(500)        NOT NULL,
    `created_at` INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at` INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at` INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `name_UNIQUE` (`name` ASC)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_wallet_transaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_wallet_transaction`;

CREATE TABLE IF NOT EXISTS `ax_wallet_transaction`
(
    `id`                            BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `wallet_id`                     BIGINT(20) UNSIGNED NOT NULL,
    `wallet_currency_id`            BIGINT(20) UNSIGNED NOT NULL,
    `wallet_transaction_subject_id` BIGINT(20) UNSIGNED NOT NULL,
    `type`                          VARCHAR(45)         NOT NULL,
    `value`                         FLOAT               NULL DEFAULT 0.0,
    `resource`                      VARCHAR(255)        NULL,
    `resource_id`                   BIGINT(20) UNSIGNED NULL,
    `created_at`                    INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at`                    INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at`                    INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`, `wallet_id`, `wallet_currency_id`, `wallet_transaction_subject_id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    INDEX `fk_ax_wallet_transaction_ax_wallet1_idx` (`wallet_id` ASC),
    INDEX `fk_ax_wallet_transaction_ax_wallet_currency1_idx` (`wallet_currency_id` ASC),
    INDEX `fk_ax_wallet_transaction_ax_wallet_transaction_subject1_idx` (`wallet_transaction_subject_id` ASC),
    CONSTRAINT `fk_ax_wallet_transaction_ax_wallet1`
        FOREIGN KEY (`wallet_id`)
            REFERENCES `ax_wallet` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_wallet_transaction_ax_wallet_currency1`
        FOREIGN KEY (`wallet_currency_id`)
            REFERENCES `ax_wallet_currency` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_wallet_transaction_ax_wallet_transaction_subject1`
        FOREIGN KEY (`wallet_transaction_subject_id`)
            REFERENCES `ax_wallet_transaction_subject` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_catalog_product_widgets`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_catalog_product_widgets`;

CREATE TABLE IF NOT EXISTS `ax_catalog_product_widgets`
(
    `id`                 BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `catalog_product_id` BIGINT(20) UNSIGNED NOT NULL,
    `render_id`          BIGINT(20) UNSIGNED NULL,
    `name`               VARCHAR(255)        NOT NULL,
    `title`              VARCHAR(255)        NOT NULL,
    `description`        VARCHAR(255)        NULL,
    `created_at`         INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at`         INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at`         INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`, `catalog_product_id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    INDEX `fk_ax_catalog_product_widgets_ax_catalog_product1_idx` (`catalog_product_id` ASC),
    INDEX `fk_ax_catalog_product_widgets_ax_render1_idx` (`render_id` ASC),
    CONSTRAINT `fk_ax_catalog_product_widgets_ax_catalog_product1`
        FOREIGN KEY (`catalog_product_id`)
            REFERENCES `ax_catalog_product` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_product_widgets_ax_render1`
        FOREIGN KEY (`render_id`)
            REFERENCES `ax_render` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_catalog_product_widgets_content`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_catalog_product_widgets_content`;

CREATE TABLE IF NOT EXISTS `ax_catalog_product_widgets_content`
(
    `id`                         BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `catalog_product_widgets_id` BIGINT(20) UNSIGNED NOT NULL,
    `title`                      VARCHAR(255)        NOT NULL,
    `title_short`                VARCHAR(155)        NOT NULL,
    `description`                TEXT                NULL DEFAULT NULL,
    `image`                      VARCHAR(255)        NULL DEFAULT NULL,
    `sort`                       INT(11)             NULL DEFAULT 0,
    `show_image`                 TINYINT(1)          NULL DEFAULT 1,
    `media`                      VARCHAR(255)        NULL DEFAULT NULL,
    `created_at`                 INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at`                 INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at`                 INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`, `catalog_product_widgets_id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    UNIQUE INDEX `title_UNIQUE` (`title` ASC),
    INDEX `fk_ax_catalog_product_widgets_content_ax_catalog_product_wi_idx` (`catalog_product_widgets_id` ASC),
    CONSTRAINT `fk_ax_catalog_product_widgets_content_ax_catalog_product_widg1`
        FOREIGN KEY (`catalog_product_widgets_id`)
            REFERENCES `ax_catalog_product_widgets` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ax_catalog_storage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_catalog_storage`;

CREATE TABLE IF NOT EXISTS `ax_catalog_storage`
(
    `catalog_storage_place_id` BIGINT(20) UNSIGNED NOT NULL,
    `catalog_product_id`       BIGINT(20) UNSIGNED NOT NULL,
    `quantity`                 INT                 NOT NULL DEFAULT 0,
    `created_at`               INT(11) UNSIGNED    NULL     DEFAULT NULL,
    `updated_at`               INT(11) UNSIGNED    NULL     DEFAULT NULL,
    `deleted_at`               INT(11) UNSIGNED    NULL     DEFAULT NULL,
    PRIMARY KEY (`catalog_storage_place_id`, `catalog_product_id`),
    INDEX `fk_ax_catalog_storage_ax_catalog_product1_idx` (`catalog_product_id` ASC),
    CONSTRAINT `fk_ax_catalog_storage_ax_catalog_storage_place1`
        FOREIGN KEY (`catalog_storage_place_id`)
            REFERENCES `ax_catalog_storage_place` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_catalog_storage_ax_catalog_product1`
        FOREIGN KEY (`catalog_product_id`)
            REFERENCES `ax_catalog_product` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ax_widgets_content`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_widgets_content`;

CREATE TABLE IF NOT EXISTS `ax_widgets_content`
(
    `id`          BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `widgets_id`  BIGINT(20) UNSIGNED NOT NULL,
    `title`       VARCHAR(255)        NOT NULL,
    `title_short` VARCHAR(155)        NULL,
    `description` TEXT                NULL DEFAULT NULL,
    `image`       VARCHAR(255)        NULL DEFAULT NULL,
    `sort`        INT(11)             NULL DEFAULT 0,
    `show_image`  TINYINT(1)          NULL DEFAULT 1,
    `media`       VARCHAR(255)        NULL DEFAULT NULL,
    `created_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`, `widgets_id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    UNIQUE INDEX `title_UNIQUE` (`title` ASC),
    INDEX `fk_ax_widgets_content_ax_widgets1_idx` (`widgets_id` ASC),
    CONSTRAINT `fk_ax_widgets_content_ax_widgets1`
        FOREIGN KEY (`widgets_id`)
            REFERENCES `ax_widgets` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ax_page_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_page_type`;

CREATE TABLE IF NOT EXISTS `ax_page_type`
(
    `id`          BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `resource`    VARCHAR(255)        NOT NULL,
    `title`       VARCHAR(255)        NOT NULL,
    `description` TEXT                NULL DEFAULT NULL,
    `created_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at`  INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ax_page`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ax_page`;

CREATE TABLE IF NOT EXISTS `ax_page`
(
    `id`              BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id`         BIGINT(20) UNSIGNED NOT NULL,
    `page_type_id`    BIGINT(20) UNSIGNED NOT NULL,
    `render_id`       BIGINT(20) UNSIGNED NULL,
    `is_published`    TINYINT(1) UNSIGNED NULL DEFAULT 1,
    `is_favourites`   TINYINT(1) UNSIGNED NULL DEFAULT 0,
    `is_comments`     TINYINT(1) UNSIGNED NULL DEFAULT 0,
    `is_watermark`    TINYINT(1) UNSIGNED NULL DEFAULT 1,
    `url`             VARCHAR(500)        NOT NULL,
    `alias`           VARCHAR(255)        NOT NULL,
    `title`           VARCHAR(255)        NOT NULL,
    `title_short`     VARCHAR(155)        NULL DEFAULT NULL,
    `description`     TEXT                NULL DEFAULT NULL,
    `title_seo`       VARCHAR(255)        NULL DEFAULT NULL,
    `description_seo` VARCHAR(255)        NULL DEFAULT NULL,
    `image`           VARCHAR(255)        NULL DEFAULT NULL,
    `media`           VARCHAR(255)        NULL DEFAULT NULL,
    `hits`            INT(11) UNSIGNED    NULL DEFAULT 0,
    `sort`            INT(11)             NULL DEFAULT 0,
    `created_at`      INT(11) UNSIGNED    NULL DEFAULT NULL,
    `updated_at`      INT(11) UNSIGNED    NULL DEFAULT NULL,
    `deleted_at`      INT(11) UNSIGNED    NULL DEFAULT NULL,
    PRIMARY KEY (`id`, `user_id`, `page_type_id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    UNIQUE INDEX `alias_UNIQUE` (`alias` ASC),
    INDEX `fk_ax_post_ax_user1_idx` (`user_id` ASC),
    INDEX `fk_ax_post_ax_render1_idx` (`render_id` ASC),
    UNIQUE INDEX `url_UNIQUE` (`url` ASC),
    INDEX `fk_ax_page_ax_page_type1_idx` (`page_type_id` ASC),
    CONSTRAINT `fk_ax_post_ax_user10`
        FOREIGN KEY (`user_id`)
            REFERENCES `ax_user` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_post_ax_render10`
        FOREIGN KEY (`render_id`)
            REFERENCES `ax_render` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_ax_page_ax_page_type1`
        FOREIGN KEY (`page_type_id`)
            REFERENCES `ax_page_type` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `ax_user`
-- -----------------------------------------------------
START TRANSACTION;
USE `a_shop`;
INSERT INTO `ax_user` (`id`, `first_name`, `last_name`, `patronymic`, `email`, `password_hash`, `status`,
                                `remember_token`, `auth_key`, `password_reset_token`, `verification_token`,
                                `created_at`, `updated_at`, `deleted_at`)
VALUES (6, 'Алексей', 'Алексеев', 'Александрович', 'axlle@mail.ru',
        '$2y$13$DMqEjJJL9gjftb80gCt5n.fOTyoTfAEv/HsQPh2IEQa42bfNsfF5S', 10, 'kyyBBbb80b3ZflMDdsynKC0B4skxf_gF',
        'kyyBBbb80b3ZflMDdsynKC0B4skxf_gF', NULL, 'vp5HeulN9jabEM6VezE-DxbiySdd8-VY_1612026130', UNIX_TIMESTAMP(), NULL,
        NULL);

COMMIT;

