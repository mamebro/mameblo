## GET /entries/:id.json
投稿を取得する

### Example

#### Request
```
GET /api/entries/1.json?name=kumiko&auth_token=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX HTTP/1.1
```

#### Response
```
HTTP/1.1 200
Content-Type: application/json; charset=utf-8

{
  "entry": {
    "id": 1,
    "title": "タイトル: テンションが2上がってきた",
    "content": "<p>コンテンツ: 日記の本文だよー2</p>\n",
    "beans_count": 0,
    "brother": {
      "id": 1,
      "name": "kumiko"
    }
  }
}
```

## GET
自分がフォローしている人(フォロイー)の投稿を取得する

### Example

#### Request
```
GET /api/entries/home.json?name=kumiko&auth_token=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX HTTP/1.1
```

#### Response
```
HTTP/1.1 200
Content-Type: application/json; charset=utf-8

{
  "entries": [
    {
      "id": 50,
      "title": "タイトル: テンションが103上がってきた",
      "content": "<p>コンテンツ: 日記の本文だよー103</p>\n",
      "beans_count": 0,
      "brother": {
        "id": 10,
        "name": "shikakun20"
      }
    },
    {
      "id": 49,
      "title": "タイトル: テンションが102上がってきた",
      "content": "<p>コンテンツ: 日記の本文だよー102</p>\n",
      "beans_count": 0,
      "brother": {
        "id": 10,
        "name": "shikakun20"
      }
    },
    {
      "id": 48,
      "title": "タイトル: テンションが101上がってきた",
      "content": "<p>コンテンツ: 日記の本文だよー101</p>\n",
      "beans_count": 0,
      "brother": {
        "id": 10,
        "name": "shikakun20"
      }
    },
    {
      "id": 47,
      "title": "タイトル: テンションが100上がってきた",
      "content": "<p>コンテンツ: 日記の本文だよー100</p>\n",
      "beans_count": 0,
      "brother": {
        "id": 10,
        "name": "shikakun20"
      }
    },
    {
      "id": 46,
      "title": "タイトル: テンションが99上がってきた",
      "content": "<p>コンテンツ: 日記の本文だよー99</p>\n",
      "beans_count": 0,
      "brother": {
        "id": 10,
        "name": "shikakun20"
      }
    },
    {
      "id": 40,
      "title": "タイトル: テンションが93上がってきた",
      "content": "<p>コンテンツ: 日記の本文だよー93</p>\n",
      "beans_count": 0,
      "brother": {
        "id": 8,
        "name": "shikakun18"
      }
    }
  ],
  "meta": {
    "_links": {
      "latest": "https://www.mameblo.com/api/entries/home.json?since_id=50",
      "previous": "https://www.mameblo.com/api/entries/home.json?max_id=39"
    }
  }
}
```
