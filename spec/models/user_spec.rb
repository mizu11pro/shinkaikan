Rspec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { build(:user) }
    subject { test_user.valid? }

    context 'nameのカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        user.name = ''
        is_expected.to eq false
      end
      it '２文字以上: 1文字は×' do
        user.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上: 2文字は◯' do
        user.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '10文字以下: 11文字は×' do
        user.namr = Faker::Lorem.characters(number: 11)
        is_expected.to eq false
      end
      it '10文字以下: 10文字は◯' do
        user.name = Faker::Lorem.characters(number: 10)
        is_expected.to eq true
      end
      it '一意性が保たれているか' do
        user.name = other_user.name
        is_expected.to eq false
      end
    end

    context 'emailのカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        user.email = ''
        is_expected.to eq false
      end
    end

    context 'introductionのカラム' do
      let(:test_user) { user }
      it '100文字以下: 101文字は×' do
        user.introduction = Faker::Lorem.characters(numder: 101)
        is_expected.to eq false
      end
      it '100文字以下: 100文字は◯' do
        user.introduction = Faker::Lorem.characters(numbaer: 100)
      end
    end

    describe 'アソシエーションのテスト' do
      context 'Movie_commentsモデルとの関係' do
        it '1:Nの関係性か' do
          expect(User.reflect_on_association(:movie_comments).macro).to eq :has_many
        end
      end

      context 'favoritesモデルとの関係' do
        it '1:Nの関係性か' do
          expect(User.reflect_on_association(:favorites).macro).to eq :has_many
        end
      end

      context 'entriesモデルとの関係' do
        it '1:Nの関係性か' do
          expect(User.reflect_on_association(:entries).macro).to eq :has_many
        end
      end

    end
      # アソシエーションのテスト
  end
end
