$(document).on('turbolinks:load', function(event) {
  	'use strict';



	// iPad and iPod detection	
	var isiPad = function(){
		return (navigator.platform.indexOf("iPad") != -1);
	};

	var isiPhone = function(){
	    return (
			(navigator.platform.indexOf("iPhone") != -1) || 
			(navigator.platform.indexOf("iPod") != -1)
	    );
	};

	// Main Menu Superfish
	var mainMenu = function() {

		$('#fh5co-primary-menu').superfish({
			delay: 0,
			animation: {
				opacity: 'show'
			},
			speed: 'fast',
			cssArrows: true,
			disableHI: true
		});

	};

	// Parallax
	var parallax = function() {
		$(window).stellar();
	};


	// Offcanvas and cloning of the main menu
	var offcanvas = function() {

		var $clone = $('#fh5co-menu-wrap').clone();
		$clone.attr({
			'id' : 'offcanvas-menu'
		});
		$clone.find('> ul').attr({
			'class' : '',
			'id' : ''
		});

		$('#fh5co-page').prepend($clone);

		// click the burger
		$('.js-fh5co-nav-toggle').on('click', function(){

			if ( $('body').hasClass('fh5co-offcanvas') ) {
				$('body').removeClass('fh5co-offcanvas');
			} else {
				$('body').addClass('fh5co-offcanvas');
			}
			// $('body').toggleClass('fh5co-offcanvas');

		});

		$('#offcanvas-menu').css('height', $(window).height());

		$(window).resize(function(){
			var w = $(window);


			$('#offcanvas-menu').css('height', w.height());

			if ( w.width() > 769 ) {
				if ( $('body').hasClass('fh5co-offcanvas') ) {
					$('body').removeClass('fh5co-offcanvas');
				}
			}

		});	

	}

	

	// Click outside of the Mobile Menu
	var mobileMenuOutsideClick = function() {
		$(document).click(function (e) {
	    var container = $("#offcanvas-menu, .js-fh5co-nav-toggle");
	    if (!container.is(e.target) && container.has(e.target).length === 0) {
	      if ( $('body').hasClass('fh5co-offcanvas') ) {
				$('body').removeClass('fh5co-offcanvas');
			}
	    }
		});
	};


	// Animations

	var contentWayPoint = function() {
		var i = 0;
		$('.animate-box').waypoint( function( direction ) {

			if( direction === 'down' && !$(this.element).hasClass('animated') ) {
				
				i++;

				$(this.element).addClass('item-animate');
				setTimeout(function(){

					$('body .animate-box.item-animate').each(function(k){
						var el = $(this);
						setTimeout( function () {
							el.addClass('fadeInUp animated');
							el.removeClass('item-animate');
						},  k * 200, 'easeInOutExpo' );
					});
					
				}, 100);
				
			}

		} , { offset: '85%' } );
	};
	

	// Document on load.
	$(function(){
		mainMenu();
		parallax();
		offcanvas();
		mobileMenuOutsideClick();
		contentWayPoint();
		

	});

	$(".travel-image").click(function() {
	    location.href = $(this).attr("data-travel");
	});

  $(".datepicker" ).datepicker({ dateFormat: 'yy-mm-dd' }).val();

  if ($('textarea').length > 0) {
    var data = $('.ckeditor');
    $.each(data, function(i) {
      CKEDITOR.replace(data[i].id)
    });
  }

  $('#Status').change(function(){
    var status = $("#Status").val();
    if (status == "" || status == undefined) status = -1;
  	var date1 = $("#filter_by_date_start").val();
	var date2 = $("#filter_by_date_end").val();
	var date1Updated = new Date(date1.replace(/-/g,'/'));  
	var date2Updated = new Date(date2.replace(/-/g,'/'));
	if (date1Updated > date2Updated) {
		alert("Ngày bắt đầu phải nhỏ hơn ngày kết thúc!!!");
		return;
	};
    $.ajax({
        url: "articles/search_tour/" + status,
        data: { "date_filter_start": $("#filter_by_date_start").val(), "date_filter_end": $("#filter_by_date_end").val() },
        dataType:"script",
        type: "get",
        success: function(data){
           $('#Status').append(data);
        }
    });
  });

  $(".filter_by_date").val(formatDate());

  $(".filter_by_date").datepicker({
  		dateFormat: 'yy-mm-dd',
	  onSelect: function(dateText) {
	  	var date1 = $("#filter_by_date_start").val();
		var date2 = $("#filter_by_date_end").val();
		var date1Updated = new Date(date1.replace(/-/g,'/'));  
		var date2Updated = new Date(date2.replace(/-/g,'/'));
		if (date1Updated > date2Updated) {
			alert("Ngày bắt đầu phải nhỏ hơn ngày kết thúc!!!");
			return;
		};
	  	var status = $("#Status").val();
	  	if (status == "" || status == undefined) status = -1;
	    $.ajax({
	        url: "articles/search_tour/" + status,
	        data: { "date_filter_start": $("#filter_by_date_start").val(), "date_filter_end": $("#filter_by_date_end").val() },
	        dataType:"script",
	        type: "get",
	        success: function(data){
	           $('#Status').append(data);
	        }
	    });
	  }
	});
});

function formatDate() {
    var d = new Date(),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;

    return [year, month, day].join('-');
}