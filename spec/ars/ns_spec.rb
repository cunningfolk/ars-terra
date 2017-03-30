module M1
  module M2
  end
  class C1
  end
end

module M2
  class C2
  end
end

class C1
end


module Ars
  RSpec.describe EnumerableModule do
    example do
      p M1.constants
    end
  end
end

module Ars
  RSpec.describe NS do
    describe M1 do
      it { is_expected.to respond_to :ns }
      it { is_expected.to have_attributes ns: nil}
      describe M1::M2 do
        it { is_expected.to have_attributes ns: M1}
      end
      describe M1::C1 do
        subject { M1::C1 }
        it { is_expected.to have_attributes ns: M1}
      end
    end
  end
end
