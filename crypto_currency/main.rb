# 实现了一个最简单的中心化区块链数字货币
# 如果要去中心化就要加入难题验证
# 比特币的做法是计算得到一个很难得到的数学值，但是这个数据值很容易验证是对的


require './crypto_currency'
require './block'
require './transaction'

# 初始换加密货币，生成初始交易，由系统给予一个初始账户10000亿货币
cc = CryptoCurrency.new()

rsa = OpenSSL::PKey::RSA.new(2048)
public_key = rsa.public_key

t1 = Transaction.new(cc.public_key, cc.private_key, public_key, 1000) 
p t1
cc.accept_transaction(t1)
# 如果交易链为空
cc.block_chain  

p cc.block_chain.length

p cc.block_chain

p cc.cal_account_money(public_key)
p cc.cal_account_money(cc.public_key)                                                                                                                                                                                                                                             