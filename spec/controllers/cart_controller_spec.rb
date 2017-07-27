require 'rails_helper'

RSpec.describe CartController, type: :controller do
  login_user

  describe "GET #edit" do
    it "200を返すこと" do
      get :edit
      expect(response).to have_http_status(200)
    end

    describe '@cart' do
      context 'current_cartがある場合' do
        let!(:cart) { controller.current_cart(create_cart_if_necessary: true) }

        it 'current_cartを返すこと' do
          expect { get :edit }.not_to change(Cart, :count).from(1)
          expect(assigns(:cart)).to eq cart
        end
      end
      context 'current_cartがない場合' do
        it 'Cartのnewインスタンスを返すこと' do
          expect { get :edit }.not_to change(Cart, :count).from(0)
          expect(assigns(:cart)).to be_a Cart
        end
      end
    end
  end

  describe 'GET #cart_link' do
    it '200を返すこと' do
      get :cart_link
      expect(response).to have_http_status(200)
    end

    it 'shared/link_to_cartをrenderすること' do
      get :cart_link
      expect(response).to render_template(partial: 'shared/_link_to_cart')
    end
  end

  describe 'PUT populate' do
    let!(:product) { FactoryGirl.create(:product) }

    describe 'redirect' do
      context '正常な入力値で商品追加' do
        it 'カート詳細画面へリダイレクトすること' do
          put :populate, params: { product_id: product.id, quantity: 1 }
          expect(response).to redirect_to cart_path
        end
      end
      context '異常な入力値で商品追加' do
        it 'ルート画面へリダイレクトすること' do
          put :populate, params: { product_id: product.id, quantity: -1 }
          expect(assigns(:cart).errors.messages[:base]).to be_present
          expect(response).to redirect_to products_path
        end
      end
    end

    describe '@cart' do
      it 'Cartインスタンスを返すこと' do
        put :populate, params: { product_id: product.id, quantity: 1 }
        expect(assigns(:cart)).to be_a Cart
        expect(assigns(:cart).reload.cart_items.first.product_id).to eq product.id
        expect(assigns(:cart).reload.cart_items.first.quantity).to eq 1
      end
    end
  end

  describe 'PUT #update' do
    before do
      @cart = controller.current_cart(create_cart_if_necessary: true)
      @product = FactoryGirl.create(:product)
      @cart_item = FactoryGirl.create(:cart_item, cart_id: @cart.id, product_id: @product.id, quantity: 1)
      @cart.reload
      @product.reload
    end
    let(:cart_items_attributes) { { "0" => { "id" => @cart_item.id, "quantity" => 4 } } }

    it 'カート詳細画面へリダイレクトすること' do
      put :update, params: { cart: { cart_items_attributes: cart_items_attributes } }
      expect(response).to redirect_to cart_path
    end

    describe '@cart' do
      it 'Cartインスタンスを返すこと' do
        put :update, params: { cart: { cart_items_attributes: cart_items_attributes } }
        expect(assigns(:cart)).to be_a Cart
        expect(assigns(:cart).reload.cart_items.first.product_id).to eq @product.id
        expect(assigns(:cart).reload.cart_items.first.quantity).to eq 4
      end
    end
  end
end
