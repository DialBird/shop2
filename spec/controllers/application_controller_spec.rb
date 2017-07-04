require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe '#current_cart' do
    context 'カートがある' do
      let!(:cart) { controller.current_cart(create_cart_if_necessary: true) }

      context 'create_cart_if_necessaryがtrue' do
        subject { controller.current_cart }
        it '使用中のカートを返す' do
          expect{ subject }.not_to change(Cart, :count)
          expect(subject).to eq cart
        end
      end
      context 'デフォルト' do
        subject { controller.current_cart }
        it '使用中のカートを返す' do
          expect{ subject }.not_to change(Cart, :count)
          expect(subject).to eq cart
        end
      end
    end

    context 'カートがない' do
      context 'create_cart_if_necessaryがtrue' do
        subject { controller.current_cart(create_cart_if_necessary: true) }

        it '新しくカートを作って返す' do
          expect{ subject }.to change(Cart, :count).from(0).to 1
          expect(subject).to be_a Cart
        end
      end
      context 'デフォルト' do
        subject { controller.current_cart }

        it 'nilを返す' do
          expect{ subject }.not_to change(Cart, :count)
          expect(subject).to be_nil
        end
      end
    end
  end
end
