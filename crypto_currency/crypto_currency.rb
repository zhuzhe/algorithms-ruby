require 'openssl'
require './transaction'

class CryptoCurrency

  INIT_COIN = 1000000000000

  def initialize
    # 区块链
    @block_chain = []
    # 生成初始交易，由系统给予一个初始账户10000亿货币
    # 账户就是私钥，这里为了方便采用rsa非对称加密算法
    rsa = OpenSSL::PKey::RSA.new(2048)
    private_key = rsa.to_pem
    @private_key = private_key
    # p "初始账户私钥：#{private_key}"
    public_key  = rsa.public_key.to_pem
    @public_key = public_key
    # p "初始账户公钥：#{public_key}"
    # 交易记录需要记录公钥(账户地址)，并用私钥签名
    # 给自己加虚拟货币
    transaction = Transaction.new(public_key, private_key, public_key, INIT_COIN)
    accept_transaction(transaction)
  end

  def private_key
    @private_key
  end

  def public_key
    @public_key
  end
  
  def self.check_block_chain()
    @block_chain.each do |block|
      block
    end
  end

  def block_chain
    @block_chain
  end

  def accept_transaction(transaction)
    if @block_chain.length == 0
      @block_chain << transaction
      return
    end
    # 验证交易是否是本人发出。第一个初始化的交易不验证
    # p transaction.valid?
    if !transaction.valid?
      p "交易签名验证失败"
      return 
    end
    # 发起交易者的余额
    from_cur_money = cal_account_money(transaction.from)
    # 如果余额小于等于0，则交易不成立
    p from_cur_money
    if from_cur_money <= 0 or from_cur_money < transaction.money
      p "余额不足"
      return 
    end
    # 设置此交易发交易id
    transaction.pre = @block_chain.last.id
    # 把交易加入区块链
    @block_chain << transaction
    transaction
  end

  # 计算某个非初始账户的余额
  def cal_account_money(public_key)
    amount = 0
    if public_key == @block_chain[0].to
      amount += @block_chain[0].money
    end
    @block_chain[1..(@block_chain.length - 1)].each do |block|
      p block.money
      if block.from == public_key
        amount = amount - block.money
        next
      end
      if block.to == public_key
        amount = amount + block.money
        next
      end      
    end
    amount
  end

end
