module ArsModule
  class Configuration
    include Ars::AttachedConfig

    attr_accessor :ars_attr
    attr_reader :sub_service

    def initialize
      @ars_attr = :my_value
      @sub_service = SubService
    end
  end
  module SubService
    class Configuration
      include Ars::AttachedConfig

      attr_accessor :ars_attr

      def initialize
        @ars_attr = :sub_value
      end
    end
  end
end

module Ars
  RSpec.describe AttachedConfig do

    describe ArsModule do
      before { [ArsModule, ArsModule::SubService].each{|config| config.configuration = nil} }
      it { is_expected.to respond_to :configuration }
      it { is_expected.to respond_to :configuration= }
      it { is_expected.to respond_to :configure }

      describe ArsModule.singleton_methods do
        it { is_expected.to contain_exactly :configuration, :configuration=, :configure }
      end

      describe ArsModule.configuration do
        subject { ArsModule.configuration }

        it { is_expected.to_not be_nil }
        it { is_expected.to be_a ArsModule::Configuration }

        context "when setting an option" do
          example do
            p subject
            ArsModule.configure do |c|
              c.ars_attr = :new_value
              p c
            end
            is_expected.to have_attributes ars_attr: :new_value
          end
        end
        context "when setting the same sub option" do
          example do
            ArsModule.configure do |c|
              c.sub_service.configure do |ssc|
                ssc.ars_attr = :new_sub_value
              end
            end
            is_expected.to have_attributes ars_attr: :my_value
          end
        end
        context "when setting the wrong option" do
          example do
            expect{subject.no_attr = :new_value}.to raise_error NoMethodError
          end
        end

      end

      describe ArsModule::Configuration do
        it { is_expected.to have_attributes ars_attr: :my_value }
        it { is_expected.to have_attributes sub_service: be(ArsModule::SubService) }
      end

      describe ArsModule::SubService.configuration do
        it { is_expected.to have_attributes ars_attr: :sub_value}
      end
    end
  end
end
