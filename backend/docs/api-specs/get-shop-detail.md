# GET /api/shops/{shopId}

## 概要

指定された店舗の詳細を取得する。店舗情報・店舗画像に加え、その店舗が提供する珈琲豆の一覧（画像・テイスト評価含む）を返す。

## リクエスト

| 項目 | 値 |
|------|---|
| メソッド | GET |
| パス | `/api/shops/{shopId}` |
| パスパラメータ | `shopId` (String) - 店舗ID |

## レスポンス

### 200 OK

```json
{
  "id": "01JSHOP0000000000000000001",
  "name": "珈琲工房 まめとしょ",
  "introduction": "東京都渋谷区にある自家焙煎珈琲店。厳選されたスペシャルティコーヒーをお届けします。",
  "particular": "シングルオリジンの豆を、注文後に焙煎してお届けします。",
  "images": [
    {
      "type": "main",
      "imageUrl": "https://placehold.jp/150x150.png"
    }
  ],
  "coffeeBeans": [
    {
      "id": "01JBEAN0000000000000000001",
      "name": "エチオピア イルガチェフェ G1",
      "description": "花のような華やかなフレーバーと、柑橘系の明るい酸味が特徴。クリーンカップで後味もすっきり。",
      "origin": "エチオピア",
      "farm": "イルガチェフェ コチャレ地区",
      "roastLevel": "light",
      "processingMethod": "washed",
      "images": [
        {
          "type": "main",
          "imageUrl": "https://placehold.jp/150x150.png"
        }
      ],
      "tastes": [
        {
          "tasteName": "酸味",
          "evaluationValue": 5
        },
        {
          "tasteName": "苦味",
          "evaluationValue": 1
        }
      ]
    },
    {
      "id": "01JBEAN0000000000000000002",
      "name": "グアテマラ アンティグア",
      "description": "チョコレートのような甘いコクと、スパイシーな余韻。バランスの良い味わいが楽しめます。",
      "origin": "グアテマラ",
      "farm": "アンティグア農園",
      "roastLevel": "city",
      "processingMethod": "fully_washed",
      "images": [
        {
          "type": "main",
          "imageUrl": "https://placehold.jp/150x150.png"
        }
      ],
      "tastes": [
        {
          "tasteName": "酸味",
          "evaluationValue": 3
        },
        {
          "tasteName": "苦味",
          "evaluationValue": 3
        }
      ]
    }
  ]
}
```

### 404 Not Found

指定された `shopId` に該当する店舗が存在しない場合。

```json
{
  "timestamp": "2026-02-23T12:00:00.000+00:00",
  "status": 404,
  "error": "Not Found",
  "path": "/api/shops/01JSHOP0000000000000000099"
}
```

## 取得するデータの範囲

Shopを起点に、以下を結合して取得する：

| テーブル | 結合条件 | 取得項目 |
|---------|---------|---------|
| `shops` | 起点 | id, name, introduction, particular |
| `shop_images` | shops.id | type, image_url |
| `coffee_beans` | shops.id | id, name, description, origin, farm, roast_level, processing_method |
| `coffee_bean_images` | coffee_beans.id | type, image_url |
| `coffee_bean_tastes` | coffee_beans.id | evaluation_value |
| `tastes` | coffee_bean_tastes.tastes_id | name |
