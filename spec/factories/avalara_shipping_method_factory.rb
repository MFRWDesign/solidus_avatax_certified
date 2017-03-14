FactoryGirl.define do
  factory :avalara_shipping_method, class: Spree::ShippingMethod do
    zones { |a| [Spree::Zone.find_by(name: 'GlobalZone') || create(:zone, :with_country, default_tax: true)] }
    name 'Avalara Ground'
    code 'Avalara_Ground'
    association(:calculator, factory: :shipping_calculator, strategy: :create)

    before(:create) do |shipping_method, evaluator|
      if Spree::Country.count == 0
        create(:country)
      end
      shipping_tax_rate = create(:shipping_tax_rate)
      shipping_method.tax_category = shipping_tax_rate.tax_category
      if shipping_method.shipping_categories.empty?
        shipping_method.shipping_categories << (Spree::ShippingCategory.first || create(:shipping_category))
      end
    end
  end
end
