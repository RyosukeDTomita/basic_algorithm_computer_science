# ハッシュテーブル(Hash Table)

## HOW TO RUN

### Haskell

`Hashable`はNon boot libraryなので、exposedされていない。そのため、以下のように`-package`オプションで明示的に指定して実行が必要。

```shell
runghc -package=hashable hash.hs
```

> [!NOTE]
> HLSに認識させるために`hie.yaml`を追加した。
