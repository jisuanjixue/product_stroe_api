require 'swagger_helper'

describe 'Products API' do

  path '/api/v1/products' do

    post 'Creates a product' do
      tags 'Products'
      consumes 'application/json', 'application/xml'
      parameter title: :product, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          price: { type: :integer },
          published: { type: :boolean }
        },
        required: [ 'title', 'price', 'published' ]
      }

      response '201', 'product created' do
        let(:product) { { title: 'phone', price: 12.5, published: true } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:product) { { title: 'foo' } }
        run_test!
      end
    end
  end

  path '/api/v1/products/{id}' do

    get 'Retrieves a product' do
      tags 'Products'
      produces 'application/json', 'application/xml'
      parameter title: :id, :in => :path, :type => :string

      response '200', 'title found' do
        schema type: :object,
          properties: {
            id: { type: :integer, },
            title: { type: :string },
            price: { type: :integer },
            published: { type: :boolean }
          },
          required: [ 'id', 'title', 'price', 'published' ]

        let(:id) { product.create(title: 'foo', price: 13.5, published: true).id }
        run_test!
      end

      response '404', 'product not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end