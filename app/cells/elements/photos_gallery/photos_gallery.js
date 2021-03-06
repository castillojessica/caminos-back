CDLV.Components['photos/gallery'] = Backbone.View.extend({
  events: {
  'click .slick-slide': 'pictureClick',
  'click .photo-gallery-livebox': 'closeLiveboxClick',
  },
  initialize: function(options) {
    _.bindAll(
        this,
        'pictureClick'
    )
    $photoGalleryCarousel = this.$el.find('.photo-gallery-carousel')
    $photoGalleryLivebox = this.$el.find('.photo-gallery-livebox')
    $photoGalleryLiveboxImage = this.$el.find('.photo-gallery-livebox img')
    $photoGalleryCarousel.slick({
      infinite: false,
      speed: 300,
      slidesToShow: 3,
      slidesToScroll: 3,
      centerMode: false,
      responsive: [
        {
          breakpoint: 1024,
          settings: {
            arrows: false,
            dots: false,
            slidesToShow: 1,
            slidesToScroll: 1,
          }
        },
      ]
    });
    CDLV.pubSub.on({
      'photos-gallery:show': this.openFullPhoto,
      'photos-gallery:close': this.closeFullPhoto,
    })
    this.isMobile = $('body').hasClass('mobile-layout');
  },
  pictureClick: function(ev) {
    if (this.isMobile) return
    var src = ev.target.src
    CDLV.pubSub.trigger('photos-gallery:show', src)
  },
  closeLiveboxClick: function(ev) {
    CDLV.pubSub.trigger('photos-gallery:close')
  },
  openFullPhoto: function(src) {
    $photoGalleryLiveboxImage.attr('src', src)
    $photoGalleryLivebox.addClass('show')
  },
  closeFullPhoto: function() {
    $photoGalleryLivebox.removeClass('show')
  }
})
