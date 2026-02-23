CREATE TABLE IF NOT EXISTS shops (
    id              CHAR(26)      NOT NULL PRIMARY KEY                         COMMENT '店舗ID',
    name            VARCHAR(255)  NOT NULL                                     COMMENT '店舗名',
    introduction    TEXT                                                       COMMENT '店舗紹介',
    particular      TEXT                                                       COMMENT 'こだわり',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP                             COMMENT '作成日時',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='店舗マスタテーブル';

CREATE TABLE IF NOT EXISTS tastes (
    id   CHAR(26)     NOT NULL PRIMARY KEY                                     COMMENT 'テイストID',
    name VARCHAR(255) NOT NULL                                                 COMMENT 'テイスト名',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP                             COMMENT '作成日時',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='テイストマスタテーブル';

CREATE TABLE IF NOT EXISTS coffee_list_groups (
    id          CHAR(26) NOT NULL PRIMARY KEY                                  COMMENT 'グループID',
    description TEXT                                                           COMMENT 'グループの説明',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP                             COMMENT '作成日時',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='珈琲リストグループマスタテーブル';

CREATE TABLE IF NOT EXISTS coffee_beans (
    id                CHAR(26)      NOT NULL PRIMARY KEY                       COMMENT '珈琲豆ID',
    shop_id           CHAR(26)      NOT NULL                                   COMMENT '店舗ID',
    name              VARCHAR(255)  NOT NULL                                   COMMENT '珈琲豆名',
    description       TEXT          NOT NULL                                     COMMENT '説明',
    origin            VARCHAR(255)  NOT NULL                                   COMMENT '産地',
    farm              VARCHAR(255)                                             COMMENT '農園',
    roast_level       ENUM('light', 'medium', 'city', 'french') NOT NULL       COMMENT '焙煎度',
    processing_method ENUM('fully_washed', 'washed', 'thermal_shock_natural', 'natural', 'wet_hulling', 'honey') NOT NULL COMMENT '精製方法',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP                             COMMENT '作成日時',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
    FOREIGN KEY (shop_id) REFERENCES shops (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='珈琲豆のマスタテーブル';

CREATE TABLE IF NOT EXISTS coffee_bean_images (
    id            CHAR(26)      NOT NULL PRIMARY KEY                           COMMENT '画像ID',
    coffee_bean_id CHAR(26)     NOT NULL                                       COMMENT '珈琲豆ID',
    type          ENUM('main') NOT NULL                                        COMMENT '画像種別',
    image_url     VARCHAR(2048) NOT NULL                                       COMMENT '画像URL',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP                             COMMENT '作成日時',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
    FOREIGN KEY (coffee_bean_id) REFERENCES coffee_beans (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='珈琲豆の画像テーブル';

CREATE TABLE IF NOT EXISTS coffee_bean_tastes (
    id               CHAR(26) NOT NULL PRIMARY KEY                             COMMENT '評価ID',
    coffee_bean_id   CHAR(26) NOT NULL                                         COMMENT '珈琲豆ID',
    tastes_id        CHAR(26) NOT NULL                                         COMMENT 'テイストID',
    evaluation_value INT      NOT NULL                                         COMMENT '評価値',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP                             COMMENT '作成日時',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
    UNIQUE (coffee_bean_id, tastes_id),
    FOREIGN KEY (coffee_bean_id) REFERENCES coffee_beans (id),
    FOREIGN KEY (tastes_id) REFERENCES tastes (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='珈琲豆のテイスト評価テーブル';

CREATE TABLE IF NOT EXISTS shop_images (
    id        CHAR(26)      NOT NULL PRIMARY KEY                               COMMENT '画像ID',
    shop_id   CHAR(26)      NOT NULL                                           COMMENT '店舗ID',
    type      ENUM('main') NOT NULL                                            COMMENT '画像種別',
    image_url VARCHAR(2048) NOT NULL                                           COMMENT '画像URL',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP                             COMMENT '作成日時',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
    FOREIGN KEY (shop_id) REFERENCES shops (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='店舗の画像テーブル';

CREATE TABLE IF NOT EXISTS coffee_list_childs (
    id                   CHAR(26) NOT NULL PRIMARY KEY                         COMMENT '明細ID',
    coffee_list_group_id CHAR(26) NOT NULL                                     COMMENT 'グループID',
    coffee_bean_id       CHAR(26) NOT NULL                                     COMMENT '珈琲豆ID',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP                             COMMENT '作成日時',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
    UNIQUE (coffee_bean_id),
    FOREIGN KEY (coffee_list_group_id) REFERENCES coffee_list_groups (id),
    FOREIGN KEY (coffee_bean_id) REFERENCES coffee_beans (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='珈琲リスト明細テーブル';
