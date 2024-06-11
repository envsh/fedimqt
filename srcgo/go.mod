module main

go 1.22.3

require github.com/kitech/gopp v0.0.0

// require github.com/kitech/gopp/cgopp v0.0.0
replace github.com/kitech/gopp => ../../goplusplus

replace github.com/kitech/gopp/cgopp => ../../goplusplus/cgopp

require (
	// fedimac v0.0.0
	github.com/ebitengine/purego v0.7.1
)


// replace github.com/kitech/gopp/cgopp => ../../goplusplus/cgopp
replace github.com/envsh/fedind/guiclish => ../../fedindgo/guiclish

replace github.com/envsh/fedind/backend => ../../fedindgo/backend

replace github.com/envsh/fedind/envcfg => ../../fedindgo/envcfg

replace github.com/envsh/fedind/statics => ../../fedindgo/statics

require (
	git.ekzyis.com/ekzyis/nip44 v0.0.0-20231230170032-ddde532a9e6c // indirect
	github.com/Kasita-Inc/gadget v0.0.0-20181214222941-00e7cc205221 // indirect
	github.com/PuerkitoBio/goquery v1.9.2 // indirect
	github.com/Workiva/go-datastructures v1.1.5 // indirect
	github.com/ably/ably-go v1.2.17 // indirect
	github.com/adrg/strutil v0.3.1 // indirect
	github.com/andybalholm/cascadia v1.3.2 // indirect
	github.com/aws/aws-sdk-go v1.44.256 // indirect
	github.com/beevik/etree v1.3.0 // indirect
	github.com/bitly/go-simplejson v0.5.1 // indirect
	github.com/btcsuite/btcd/btcec/v2 v2.3.2 // indirect
	github.com/btcsuite/btcd/btcutil v1.1.3 // indirect
	github.com/btcsuite/btcd/chaincfg/chainhash v1.0.2 // indirect
	github.com/cheekybits/genny v1.0.0 // indirect
	github.com/chzyer/readline v1.5.1 // indirect
	github.com/decred/dcrd/crypto/blake256 v1.0.1 // indirect
	github.com/decred/dcrd/dcrec/secp256k1/v4 v4.3.0 // indirect
	github.com/djherbis/times v1.6.0 // indirect
	github.com/dolthub/maphash v0.1.0 // indirect
	github.com/emirpasic/gods v1.18.1 // indirect
	github.com/envsh/fedind/backend v0.0.0-00010101000000-000000000000 // indirect
	github.com/envsh/fedind/envcfg v0.0.0 // indirect
	github.com/envsh/fedind/guiclish v0.0.0-00010101000000-000000000000 // indirect
	github.com/envsh/fedind/statics v0.0.0 // indirect
	github.com/go-stack/stack v1.8.1 // indirect
	github.com/gobwas/httphead v0.1.0 // indirect
	github.com/gobwas/pool v0.2.1 // indirect
	github.com/gobwas/ws v1.2.0 // indirect
	github.com/golang/protobuf v1.4.2 // indirect
	github.com/google/uuid v1.6.0 // indirect
	github.com/gorilla/mux v1.8.0 // indirect
	github.com/gorilla/websocket v1.5.1 // indirect
	github.com/h2non/filetype v1.1.3 // indirect
	github.com/huandu/xstrings v1.4.0 // indirect
	github.com/jackc/chunkreader/v2 v2.0.1 // indirect
	github.com/jackc/pgconn v1.14.3 // indirect
	github.com/jackc/pgio v1.0.0 // indirect
	github.com/jackc/pgpassfile v1.0.0 // indirect
	github.com/jackc/pgproto3/v2 v2.3.3 // indirect
	github.com/jackc/pgservicefile v0.0.0-20221227161230-091c0ba34f0a // indirect
	github.com/jackc/pgtype v1.14.0 // indirect
	github.com/jackc/pgx/v4 v4.18.3 // indirect
	github.com/jackc/pgx/v5 v5.4.3 // indirect
	github.com/jackc/puddle/v2 v2.2.1 // indirect
	github.com/jaytaylor/html2text v0.0.0-20230321000545-74c2419ad056 // indirect
	github.com/jinzhu/inflection v1.0.0 // indirect
	github.com/jinzhu/now v1.1.5 // indirect
	github.com/johannesboyne/gofakes3 v0.0.0-20240217095638-c55a48f17be6 // indirect
	github.com/josharian/intern v1.0.0 // indirect
	github.com/juju/ratelimit v1.0.2 // indirect
	github.com/lytics/base62 v0.0.0-20180808010106-0ee4de5a5d6d // indirect
	github.com/mailru/easyjson v0.7.7 // indirect
	github.com/mattn/go-colorable v0.1.13 // indirect
	github.com/mattn/go-isatty v0.0.19 // indirect
	github.com/mattn/go-runewidth v0.0.9 // indirect
	github.com/mattn/go-sqlite3 v1.14.22 // indirect
	github.com/miekg/dns v1.1.59 // indirect
	github.com/nbd-wtf/go-nostr v0.30.0 // indirect
	github.com/ncruces/go-dns v1.2.5 // indirect
	github.com/olekukonko/tablewriter v0.0.5 // indirect
	github.com/orcaman/concurrent-map/v2 v2.0.1 // indirect
	github.com/pkg/errors v0.9.1 // indirect
	github.com/puzpuzpuz/xsync/v3 v3.0.2 // indirect
	github.com/rs/zerolog v1.32.0 // indirect
	github.com/ryszard/goskiplist v0.0.0-20150312221310-2dfbae5fcf46 // indirect
	github.com/sashabaranov/go-openai v1.23.0 // indirect
	github.com/shabbyrobe/gocovmerge v0.0.0-20190829150210-3e036491d500 // indirect
	github.com/sirupsen/logrus v1.7.0 // indirect
	github.com/ssor/bom v0.0.0-20170718123548-6386211fdfcf // indirect
	github.com/tidwall/gjson v1.17.1 // indirect
	github.com/tidwall/match v1.1.1 // indirect
	github.com/tidwall/pretty v1.2.0 // indirect
	github.com/tidwall/sjson v1.2.5 // indirect
	github.com/ugorji/go/codec v1.2.12 // indirect
	github.com/yitsushi/go-misskey v1.1.6 // indirect
	github.com/yuin/goldmark v1.7.1 // indirect
	go.mau.fi/util v0.4.2 // indirect
	golang.org/x/crypto v0.22.0 // indirect
	golang.org/x/exp v0.0.0-20240409090435-93d18d7e34b8 // indirect
	golang.org/x/mod v0.17.0 // indirect
	golang.org/x/net v0.24.0 // indirect
	golang.org/x/sync v0.7.0 // indirect
	golang.org/x/sys v0.19.0 // indirect
	golang.org/x/text v0.14.0 // indirect
	golang.org/x/tools v0.20.0 // indirect
	google.golang.org/protobuf v1.23.0 // indirect
	gorm.io/driver/postgres v1.5.7 // indirect
	gorm.io/gorm v1.25.9 // indirect
	maunium.net/go/mautrix v0.18.1 // indirect
	nhooyr.io/websocket v1.8.11 // indirect
)
