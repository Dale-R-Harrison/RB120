class Banner
  SPACE = ' '
  DASH = '-'

  def initialize(message)
    @message = message
    @message_length = message.size + 2
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  attr_reader :message_length

  def horizontal_rule
    "+" + DASH * message_length + "+"
  end

  def empty_line
    "|" + SPACE * message_length + "|"
  end

  def message_line
    "| #{@message} |"
  end
end

banner = Banner.new('To boldly go where no one has gone before.')
puts banner

banner = Banner.new('')
puts banner