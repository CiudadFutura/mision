module ComprasHelper
  def get_cycle_image(text)
    img = ''
    if text.include?('D3')
      img = 'oeste.png'
    end
    if text.include?('D1 y D4')
      img = 'uno_cuatro.png'
    end
    if text.include?('D2 y D5')
      img = 'dos_cinco.png'
    end
    if text.include?('D6')
      img = 'centro.png'
    end
    if text.include?('Moreno')
      img = 'moreno.png'
    end
    return img
  end
end
