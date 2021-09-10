import React from "react";
import Navbar from "../components/Navbar";
import { Link } from "react-router-dom";
import "./home.css";
import Background from "../assets/bg.png";
import fruits from "../assets/fruits.png";
import foodstaples from "../assets/foodstaples.png";
import sauces from "../assets/sauces.png";
import botlles from "../assets/botlles.png";
import veges from "../assets/veges.png";
import banner from "../assets/Blankdiagram.png";
import SearchBar from "../components/SearchBar";
import TeamSlider from "../components/Carousel";
import "aos/dist/aos.css";
import AOS from "aos";
AOS.init();
const Home = () => {
  return (
    <div>
      <div className="navbar1">
        <Navbar />
      </div>
      <div className="bg-img-container">
        <img src={Background} alt="" className="bgimg" />
        <div className="se">
          <SearchBar />
        </div>
      </div>
      <div className="container2">
        <p className="deal">Top Deals</p>
        <div className="dash2"></div>
        <p className="intro">
          Get best discount products from your nearby stores right at your home
        </p>
        <div className="image-container">
          <div className="image-box">
            <Link to="/marketplace">
              {" "}
              <img
                src={fruits}
                alt=""
                className="images"
                data-aos="zoom-in-up"
                data-aos-duration="1000"
                data-aos-easing="ease-out"
              />
            </Link>
            <p className="off">5% OFF</p>
            <p className="head">Vegetables</p>
          </div>
          <div className="image-box">
            <Link to="/marketplace">
              <img
                src={foodstaples}
                alt=""
                className="images"
                data-aos="zoom-in-up"
                data-aos-duration="1000"
                data-aos-easing="ease-out"
                data-aos-delay="200"
              />
            </Link>
            <p className="off">20% OFF</p>
            <p className="head">Staples</p>
          </div>
          <div className="image-box">
            <Link to="/marketplace">
              <img
                src={botlles}
                alt=""
                className="images"
                data-aos="zoom-in-up"
                data-aos-duration="1000"
                data-aos-easing="ease-out"
                data-aos-delay="300"
              />
            </Link>
            <p className="off">25% OFF</p>
            <p className="head">Beverages</p>
          </div>
          <div className="image-box">
            <Link to="/marketplace">
              {" "}
              <img
                src={sauces}
                alt=""
                className="images"
                data-aos="zoom-in-up"
                data-aos-duration="1000"
                data-aos-easing="ease-out"
                data-aos-delay="400"
              />
            </Link>
            <p className="off">12% OFF</p>
            <p className="head">Sauces</p>
          </div>
          <div className="image-box">
            <Link to="/marketplace">
              {" "}
              <img
                src={veges}
                alt=""
                className="images"
                data-aos="zoom-in-up"
                data-aos-duration="1000"
                data-aos-easing="ease-out"
                data-aos-delay="500"
              />
            </Link>
            <p className="off">25% OFF</p>
            <p className="head">Fruits</p>
          </div>
        </div>
      </div>
      <div className="container4">
        <p className="system">
          <span className="know">Know</span> Our System
        </p>
        <div className="dash2"></div>
        <div className="info"></div>
        <img src={banner} alt="" className="courier" />
        <div></div>
      </div>
      <div className="tom">
        <p className="teams">
          <span className="know">Meet</span> Our Team
        </p>
        <div className="dash2"></div>
        <TeamSlider />
      </div>
    </div>
  );
};

export default Home;
