require 'stabilizer'

describe Stabilizer do
  describe '#initialize' do
    it 'assigns variables via params' do
      params = {course: 60, currency: 20, rub: 1200}
      stabilizer = Stabilizer.new(params)

      expect(stabilizer.course).to eq 60
      expect(stabilizer.currency).to eq 20
      expect(stabilizer.rub).to eq 1200
    end

    context 'when all is in an balance' do
      params = {course: 60, currency: 20, rub: 1200}
      stabilizer = Stabilizer.new(params)

      it { expect(stabilizer.result).to eq 'Ваша корзина и без того уравновешена.' }
    end

    context 'when need to buy currency' do
      params = {course: 60, currency: 10, rub: 1200}
      stabilizer = Stabilizer.new(params)

      it { expect(stabilizer.result).to eq 'Вам нужно докупить: $ 5' }
    end

    context 'when need to sell currency' do
      params = {course: 60, currency: 60, rub: 1200}
      stabilizer = Stabilizer.new(params)

      it { expect(stabilizer.result).to eq 'Вам нужно продать: $ 20' }
    end
  end
end