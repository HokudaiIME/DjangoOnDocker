# DjangoによるAPI作成

* python
    - debian(slim-stretch)
    - 3.7
    
* postgres
    - alpine
    - 11.4

* nginx
    - alpine
    - 1.15.12
    
## version管理ツール
**poetry**
    
採用理由: pipenvが使えなかったため

依存関係の追加を行った場合、再ビルドが必要


### command

* 依存関係をinstall
  
```poetry install```

* パッケージの追加

```poetry add dependency```

* 開発パッケージの追加

```poetry add -D dependency```

* 仮想環境へ入る

```poetry shell```

 

