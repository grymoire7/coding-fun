require 'spec_helper'

RSpec.describe ReverseParens do
  describe '.check' do
    it 'calculates reverse parens' do
      expect(ReverseParens.check('a(bc)d')).to eq('acbd')
      expect(ReverseParens.check('a(b(cd)ef)g')).to eq('afecdbg')
    end

    it 'works for empty parens' do
      expect(ReverseParens.check('()')).to eq('')
      expect(ReverseParens.check('')).to eq('')
    end
  end
end
