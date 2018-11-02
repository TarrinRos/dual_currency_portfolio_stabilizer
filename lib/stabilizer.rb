class Stabilizer
  attr_reader :result, :course, :currency, :rub

  def initialize(params)
    @course = params['course']
    @currency = params['currency']
    @rub = params['rub']
    @valute_symbol = params['symbol']

    @result = count_buy_sell
  end

  def count_buy_sell
    # Переводит рубли в валюту по курсу
    rub_to_currency = @rub / @course

    # Считает сколько нужно продать долларов для уравновешивания корзины
    buy_sell = (rub_to_currency + @currency) / 2 - rub_to_currency

    # Определяет какая часть корзины больше
    # Если средств в корзинах одинаковое количество, или докупить/продать надо меньше 1 цента
    if buy_sell.abs <= 0.01
      'Ваша корзина и без того уравновешена.'

      # Если рублей меньше, чем долларов - продать
    elsif rub_to_currency < @currency
      "Вам нужно продать: #{@valute_symbol} #{buy_sell.round(2).to_s}"

      # Если рублей больше, чем долларов - докупить
    else
      "Вам нужно докупить: #{@valute_symbol} #{buy_sell.round(2).abs.to_s}"
    end
  end
end