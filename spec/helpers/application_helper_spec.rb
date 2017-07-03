require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe '#display_flash' do
    context 'flashがある場合' do
      let(:flash) do
        obj = {}
        obj["success"] = 'success'
        obj["warning"] = 'warning'
        obj["notice"] = 'notice'
        obj["alert"] = 'alert'
        obj
      end

      it 'それぞれ意図したクラス名でメッセージが出力されること' do
        html = []
        html << "<div class=\"alert alert-success\">success</div>"
        html << "<div class=\"alert alert-warning\">warning</div>"
        html << "<div class=\"alert alert-success\">notice</div>"
        html << "<div class=\"alert alert-danger\">alert</div>"
        display_flash
        expect(helper.output_buffer).to eq html.join('')
      end
    end
  end

  describe '#display_errors' do
    def build_error_tag(li_tags, title = '入力内容にエラーがあります')
      "<div class=\"alert alert-danger alert-dismissable\"><i class=\"fa fa-exclamation-circle\"><strong> #{title}</strong></i><ul>#{li_tags}</ul></div>"
    end
    let(:name_error_tag) do
      build_error_tag('<li>name1</li><li>name2</li>')
    end
    let(:titled_error_tag) do
      build_error_tag('<li>name1</li><li>name2</li>', 'エラー')
    end
    let(:price_first_error_tag) do
      build_error_tag('<li>price1</li><li>name1</li><li>name2</li>')
    end
    before do
      @product = FactoryGirl.create(:product)
      @product.errors.messages[:name] = %w(name1 name2)
      @product.errors.messages[:price] = %w(price1)
    end

    it '指定が無い場合はエラーメッセージが出力されないこと' do
      expect(display_errors(@product)).to be_blank
    end
    it '指定propertyのエラーメッセージが出力されること' do
      expect(display_errors(@product, [:name])).to eq name_error_tag
    end
    it 'タイトルが変更されること' do
      expect(display_errors(@product, [:name], title: 'エラー')).to eq titled_error_tag
    end
    it 'propertyの指定順にエラーメッセージが出力されること' do
      expect(display_errors(@product, [:price, :name])).to eq price_first_error_tag
    end
  end
end
