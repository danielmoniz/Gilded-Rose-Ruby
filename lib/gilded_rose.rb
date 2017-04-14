class GildedRose
  attr_reader :name, :days_remaining, :quality

  def initialize(name:, days_remaining:, quality:)
    @name = name
    @days_remaining = days_remaining
    @quality = quality
  end

  def get_backstage_quality_drop(days_remaining)
    if days_remaining <= 0
      return @quality
    elsif days_remaining <= 5
      return -3
    elsif days_remaining <= 10
      return -2
    end
    return -1
  end

  def limit_quality(quality)
    [[quality, 0].max, 50].min # force quality between 0 and 50 inclusive
  end

  def backstage_tick
    quality_drop = get_backstage_quality_drop(@days_remaining)
    @days_remaining -= 1
    @quality = limit_quality(@quality - quality_drop)
  end

  def tick
    quality_drop = 1
    if @name == 'Conjured Mana Cake'
      quality_drop = 2
    elsif @name == 'Aged Brie'
      quality_drop = -1
    elsif @name == 'Sulfuras, Hand of Ragnaros'
      return
    elsif @name == 'Backstage passes to a TAFKAL80ETC concert'
      return backstage_tick
    end

    quality_drop *= 2 if @days_remaining <= 0
    @quality = limit_quality(@quality - quality_drop)
    @days_remaining -= 1
  end
end
