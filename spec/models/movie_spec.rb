require 'rails_helper'

RSpec.describe 'Movieモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:movie) { Move.create!(title: 'test_title', body: 'test_body', directed_by: 'test_directerd_by', image: 'test_image', genre_id: 'test_genre' ) }
    subject { movie.valid? }

    context 'titleのカラム' do
      it '空白でないこと' do
        movie.title = ''
        is_expected.to eq false
      end
    end

    context 'bodyのカラム' do
      it '空白でないこと' do
        movie.body = ''
        is_expected.to eq false
      end
    end

    context 'directed_byのカラム' do
      it '空白でないこと' do
        movie.directed_by = ''
        is_expected.to eq false
      end
    end

    context 'imageのカラム' do
      it '空白でないこと' do
        movie.image = ''
        is_expected.to eq false
      end
    end

    context 'genre_idのカラム' do
      it '空白でないこと' do
        movie.genre_id
        is_expected.to eq false
      end
    end

    describe 'アソシエーションのテスト' do
      context 'Movie_commentsモデルとの関係' do
        it '1:Nの関係性か' do
          expect(Movie.reflect_on_association(:movie_comments).macro).to eq :has_many
        end
      end

      context 'favoritesモデルとの関係' do
        it '1:Nの関係性か' do
          expect(Movie.reflect_on_association(:favorites).macro).to eq :has_many
        end
      end

    end

  end
end