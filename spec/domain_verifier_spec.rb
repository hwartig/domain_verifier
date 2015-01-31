require 'spec_helper'

describe DomainVerifier do
  let(:name) { 'hWartig.com' }

  it 'has a version number' do
    expect(DomainVerifier::VERSION).not_to be nil
  end

  describe '.verify' do
    subject { described_class.verify(name) }
    let(:result) { double('domain') }

    before do
      expect_any_instance_of(DomainVerifier::Domain).to receive(:verify)
        .and_return(result)
    end

    it { should eq(result) }
  end

  describe DomainVerifier::Domain do
    subject(:domain) { described_class.new(name) }

    it { should respond_to(:whois) }

    describe '#whois' do
      it 'delegates work to whois' do
        expect(Whois).to receive(:whois).with(name.downcase)
          .and_return('whois result')
        expect(subject.whois).to eq('whois result')
      end
    end

    it { should respond_to(:to_s) }

    describe '#to_s' do
      subject { super().to_s }

      it { should eq(name.downcase) }
    end

    it { should respond_to(:http_status) }

    describe '#http_status' do
      subject { super().http_status }

      context 'when site is alive' do
        let(:http) { double('http') }

        before do
          expect(Net::HTTP).to receive(:start).with(name.downcase)
            .and_return(http)
          expect(http).to receive(:head).with('/')
            .and_return(Struct.new(:code).new(200))
        end

        it { should eq(200) }
      end
    end

    describe '#verify' do
      subject { super().verify }

      before do
        expect(domain).to receive(:whois)
        expect(domain).to receive(:http_status)
      end

      it { should eq(domain) }
    end
  end
end
