+++
date = 2019-12-28
title = 'BTCPay Server 安装配置'
categories = ['devops']
tags = [
    "devops",
    "BTC",
    "open source",
    "server",
]
+++


# Login as root

`sudo -i`

# Create a folder for BTCPay

```bash
mkdir BTCPayServer
cd BTCPayServer

# Clone this repository
git clone https://github.com/btcpayserver/btcpayserver-docker
cd btcpayserver-docker

export BTCPAY_HOST="pay.lubiao.org"

export NBITCOIN_NETWORK="mainnet"

export BTCPAYGEN_CRYPTO1="btc"

export BTCPAYGEN_ADDITIONAL_FRAGMENTS="opt-save-storage-s"

export BTCPAYGEN_REVERSEPROXY="nginx"

export BTCPAYGEN_LIGHTNING="clightning"

export BTCPAY_ENABLE_SSH=true

. ./btcpay-setup.sh -i

exit


```

[https://docs.btcpayserver.org/Docker/](https://docs.btcpayserver.org/Docker/)

[https://docs.btcpayserver.org/FAQ/FAQ-Deployment/](https://docs.btcpayserver.org/FAQ/FAQ-Deployment/)

# 如何在Linux上手动安装BTCPayServer并设置比特币BTC和Lightning支付网关

[http://blog.hubwiz.com/2019/05/23/bitcoin-btcpayserver/](http://blog.hubwiz.com/2019/05/23/bitcoin-btcpayserver/)


/stores/9JSXirghrYL4ic8VAeKjrK6yWgMQ92V3ectzyx1WempA/derivations/BTC/generatenbxwallet

[https://pay.pocplus.com/stores/9JSXirghrYL4ic8VAeKjrK6yWgMQ92V3ectzyx1WempA/derivations/BTC/generatenbxwallet](https://pay.pocplus.com/stores/9JSXirghrYL4ic8VAeKjrK6yWgMQ92V3ectzyx1WempA/derivations/BTC/generatenbxwallet)

```
1. ExistingMnemonic: 
2. Passphrase: 
3. passphrase_conf: 
4. ScriptPubKeyType:

Segwit

1. AccountNumber:

0

1. SavePrivateKeys:

true

1. __RequestVerificationToken:

CfDJ8OZKMqYtAC1CkhKIJm3CGMPlu1PaU3ZVC8xNZZjCcgtvdpklbXTmRdXD9yE_fWe55N1pq9eRx41XsNOoStamsrE2eqX7wIRkwgnQK0BfZgQ1wD0ucPQqcl-_9xn-ZIi6NwR5Ip1ZA-BuUQQ1ISAwBFM1Udwi_kRNQptbGgerK_qnJB7hktd5p-WEPsD8_RlXiw

1. SavePrivateKeys:

false

[https://pay.pocplus.com/recovery-seed-backup](https://pay.pocplus.com/recovery-seed-backup)

1. __RequestVerificationToken:

CfDJ8OZKMqYtAC1CkhKIJm3CGMNm-tWx7aE_-NQzwDixSgzTkksfocc5elkENIDZ7kC1FPdocJNKwI1Ut2_zH9QuFcqJvUtS5Y_rqK_s6n0LWTcQi2XLXI6CspD1YebUAzIQtr6dHhqsDCwbSp3sVGzbsTKe1JES3nUVrxg1uWSco9Zsn2GyNQia3iXn662J8_RkRQ

1. cryptoCode:

BTC

1. mnemonic:

youth rabbit hole dinner swim more bread rug connect topic novel umbrella

1. passphrase: 
2. isStored:

true

1. requireConfirm:

true

1. returnUrl:

/stores/9JSXirghrYL4ic8VAeKjrK6yWgMQ92V3ectzyx1WempA

```
[https://pay.pocplus.com/stores/9JSXirghrYL4ic8VAeKjrK6yWgMQ92V3ectzyx1WempA](https://pay.pocplus.com/stores/9JSXirghrYL4ic8VAeKjrK6yWgMQ92V3ectzyx1WempA)?

创建钱包的页面

[https://github.com/btcpayserver/btcpayserver/blob/master/BTCPayServer/Views/Stores/_GenerateWalletForm.cshtml](https://github.com/btcpayserver/btcpayserver/blob/master/BTCPayServer/Views/Stores/_GenerateWalletForm.cshtml)

创建钱包的代码

[https://github.com/btcpayserver/btcpayserver/blob/282d0abb62ef2f10191157093a2465be660e76f1/BTCPayServer/Controllers/StoresController.BTCLike.cs](https://github.com/btcpayserver/btcpayserver/blob/282d0abb62ef2f10191157093a2465be660e76f1/BTCPayServer/Controllers/StoresController.BTCLike.cs)

**新版本**

http://127.0.0.1:14142/stores/7GYbjwXzc7AwvcRFHXzew3RDhCHRbrRDKaijysmbuxNZ/onchain/BTC/generate/HotWallet

```
- ScriptPubKeyType:
- Segwit
- SavePrivateKeys:
- True
- Passphrase:
- passphrase_conf:
- __RequestVerificationToken:
- CfDJ8Bi74VC_UCtFq5izs_lWsqOUsSYj-6SZ5MaGPlMhoQ1AedWAGaL2ADEwq41HFNsyaJ5lQ6j581b2lcR4xeNr4-Aoksho4hB2p9iBvtctVRBqLg9A7P_1INWFljwywGf2vOPkD8kkDE4IuriaOJ1_3DapRBSWggCzekeQGD7vNZrUI4_MFd5gCJk9UV14C5fGPg
- ImportKeysToRPC:

- false


```
