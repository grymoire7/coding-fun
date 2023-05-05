require 'spec_helper'

RSpec.describe ReverseParens do
  describe '.check' do
    it 'calculates reverse parens' do
      expect(ReverseParens.check('a(bc)d')).to eq('acbd')
      expect(ReverseParens.check('a(b(cd)ef)g')).to eq('afecdbg')
    end
  end
end
