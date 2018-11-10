class Stabilizer
  attr_reader :result, :course, :currency, :rub, :amount

  def initialize(params)
    @course = params[:course]
    @currency = params[:currency]
    @rub = params[:rub]
    @amount = 0

    @result = count_buy_sell
  end

  def count_buy_sell
    # Переводит рубли в валюту по курсу
    rub_to_currency = @rub / @course

    # Считает сколько нужно продать долларов для уравновешивания корзины
    amount = (rub_to_currency + @currency) / 2 - rub_to_currency

    # Определяет какая часть корзины больше
    if amount.abs <= 0.01
      # Если средств в корзинах одинаковое количество, или докупить/продать надо меньше 1 цента
      :balanced
    elsif rub_to_currency < @currency
      # Если рублей меньше, чем долларов - продать
      @amount = amount.round(2).to_s
      :sell
    else
      # Если рублей больше, чем долларов - докупить
      @amount = amount.round(2).abs.to_s
      :buy
    end
  end
end