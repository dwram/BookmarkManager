require_relative '../models/database'
require_relative './spec_helper'

describe DatabaseConnection do

  context 'setup the database via PG' do

    it '#setup' do
      expect(DatabaseConnection.setup('bookmark_manager_test').class).to eq PG::Connection
    end

  end

end