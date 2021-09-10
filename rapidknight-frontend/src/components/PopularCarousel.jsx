import React, { Component } from "react";
import Slider from "react-slick";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import JSON from "../components/DATA.json";
import { Link } from "react-router-dom";
import "./popularcarousel.css";
export default class PopularCarousel extends Component {
  render() {
    const product = JSON;
    const settings = {
      dots: false,
      infinite: true,
      speed: 500,
      slidesToShow: 5,
      slidesToScroll: 2,
      centerPadding: "60px",
      autoplay: true,
      autoplaySpeed: 2000,
      responsive: [
        {
          breakpoint: 1024,
          settings: {
            slidesToShow: 3,
            slidesToScroll: 3,
            infinite: true,
            dots: false,
          },
        },
        {
          breakpoint: 600,
          settings: {
            slidesToShow: 2,
            slidesToScroll: 2,
            initialSlide: 2,
          },
        },
        {
          breakpoint: 480,
          settings: {
            slidesToShow: 2,
            slidesToScroll: 1,
          },
        },
      ],
    };
    return (
      <div>
        <p className="popular">
          <span className="p">Popular</span> Searches
        </p>
        <Slider {...settings}>
          {product
            .filter((item) => {
              if (item.popular === true) {
                return item;
              }
            })
            .map((item) => {
              return (
                <>
                  <div
                    className="cards1"
                    data-aos="fade-down"
                    data-aos-duration="1200"
                  >
                    <img src={item.url} alt="" className="img1" />

                    <p className="tit">{item.title}</p>
                    <p className="desc">{item.Description}</p>
                  </div>

                  <Link to={`/basket/${item.id}/${item.title}`}>
                    <button className="add">Add to Basket</button>
                  </Link>
                </>
              );
            })}
        </Slider>
      </div>
    );
  }
}
