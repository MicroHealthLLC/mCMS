class ExceptionNotifier < ApplicationRecord
  def self.create(e)
    super(title: e.message, content: e.backtrace)
  rescue
    puts 'error on creating'
  end
end
