require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: "Michael", email: "user@example.com")}

  it 'should be valid' do
    expect(subject.valid?).to eq(true)
  end

  context 'valid fields' do

    context 'present fields' do

      it 'name should be present' do
          subject.name = " "
          expect(subject.valid?).not_to eq(true)
      end

      it 'email should be present' do
        subject.email = " "
        expect(subject.valid?).not_to eq(true)
      end

    end

    context 'field length' do

      it 'name should not be too long' do
        subject.name = 'a'*51
        expect(subject.valid?).not_to eq(true)
      end

      it 'email should not be too long' do
        subject.email = 'a' * 256
        expect(subject.valid?).not_to eq(true)
      end

    end

    context 'valid email' do

      it 'should have valid format' do
        valid_addresses = %w[user@example.com USER@eXaMple.COM AUS-EUR@Goo.com
                             theOneAndOnly.theFirst.MostIllustrous@gogglemama.com]
        valid_addresses.each do |valid_address|
          subject.email = valid_address
          expect(subject.valid?).to eq(true)
        end
      end

      it 'should reject invalid format' do
        invalid_addresses = %w[user@example,com user.example user@example@xom user@goo+goo.com]
        invalid_addresses.each do |invalid_address|
          subject.email = invalid_address
          expect(subject.valid?).not_to eq(true)
        end
      end

      it 'should be unique' do
        duplicate_user = subject.dup
        duplicate_user.email.upcase!
        subject.save
        expect(duplicate_user.valid?).not_to eq(true)
      end

    end

  end
end
