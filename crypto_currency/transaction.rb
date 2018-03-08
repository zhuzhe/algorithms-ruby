require 'openssl'
require "base64"


class Transaction

  def initialize(from , private_key, to, money)
    # 发送者账户
    @from = from
    # 接受者账户
    @to = to
    # 交易金额
    @money = money
    # 签名私钥
    @private_key = private_key
    # 签名
    @sign = ''
    # 上一个交易的数字签名
    @pre = nil
    # 做签名
    do_sign()
  end

  def do_sign()
    # 签名的内容
    msg = msg2sign()
    @sign = Base64.encode64 OpenSSL::PKey::RSA.new(@private_key).sign(OpenSSL::Digest::SHA256.new, msg)
  end

  def msg2sign
    "#{@from}#{@to}#{@money}"
  end

  def pre=(pre)
    @pre = pre
  end

  def valid?()
    OpenSSL::PKey::RSA.new(@from).verify(OpenSSL::Digest::SHA256.new, Base64.decode64(@sign), msg2sign)
  end

  def id
    OpenSSL::Digest::SHA256.new.digest("#{@from}#{@to}#{@money}#{@sign}")
  end

  def from
    @from
  end

  def to
    @to
  end

  def sign
    @sign
  end

  def money
    @money
  end

end