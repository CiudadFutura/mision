module ComprasHelper
  def get_cycle_image(text)
    img = ''
    if text.include?('Distrito 3')
      img = 'v2/oeste.png'
    end
    if text.include?('Distritos 1 y 4')
      img = 'v2/sur2.png'
    end
    if text.include?('Distritos 2 y 5')
      img = 'v2/norte.png'
    end
    if text.include?('Distritos 6')
      img = 'v2/centro.png'
    end
    return img
  end
end
