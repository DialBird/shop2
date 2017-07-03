require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe '#current_cart' do
    context 'ログイン前' do
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

          it '新しくカートを作って返す(user_idなし)' do
            expect{ subject }.to change(Cart, :count).from(0).to 1
            expect(subject).to be_a Cart
            expect(subject.user_id).to be_nil
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
    context 'ログイン後' do
      login_user
      let(:user) { controller.current_user }

      context 'カートがある' do
        let!(:cart) { controller.current_cart(create_cart_if_necessary: true) }

        context 'create_cart_if_necessaryがtrue' do
          subject { controller.current_cart(create_cart_if_necessary: true) }

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

          it '新しくカートを作って返す(user_idあり)' do
            expect{ subject }.to change(Cart, :count).from(0).to 1
            expect(subject).to be_a Cart
            expect(subject.user_id).to eq user.id
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
end
