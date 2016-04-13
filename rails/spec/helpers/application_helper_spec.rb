require 'rails_helper'

describe ApplicationHelper do
  describe 'markdown' do
    subject { helper.markdown(arg) }

    context 'when "# x\r\n## y" is specified' do
      let(:arg) { "# x\r\n## y" }
      it { is_expected.to eq "<h1>x</h1>\n\n<h2>y</h2>" }
    end
  end
end
