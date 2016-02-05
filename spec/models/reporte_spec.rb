require 'rails_helper'

RSpec.describe Producto, :type => :model do
    describe 'pedidos_por_proveedor' do
        before do
            create(:prod1)
            create(:prod2)
            create(:prod3)
        end

        it 'returns an empty array' do
            reporte = Reporte.pedidos_por_proveedor([])
            expect(reporte).to eq({})
        end

        it 'return an array of supliers' do
            reporte = Reporte.pedidos_por_proveedor(pedidos)
            expected = {
                1 => {
                    name: 'Proveedor 1',
                    supplier_id: 1,
                    products: {
                        1 => {name: 'prod1', qty: 2},
                        2 => {name: 'prod2', qty: 2}
                    }
                },
                2 => {
                    name: 'Proveedor 2',
                    supplier_id: 2,
                    products: {
                        3 => {name: 'prod3', qty: 3}
                    }
                }
            }
            expect(reporte).to eq(expected)
        end
    end

    def pedidos
        [
            build_pedido([
                {producto_id: 1, cantidad: 1},
                {producto_id: 2, cantidad: 2}
            ]),
            build_pedido([
                {producto_id: 3, cantidad: 3}
            ]),
            build_pedido([
                {producto_id: 1, cantidad: 1}
            ])
        ]
    end

    def build_pedido(prod_array)
        pedido = double("pedido")
        allow(pedido).to receive(:items) { prod_array.to_json }
        return pedido
    end

end