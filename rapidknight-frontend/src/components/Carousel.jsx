import React, { Component } from "react";
import "./carousl.css";
import bhurva from "../assets/bhurvs.jpeg";
import kartikey from "../assets/kar.jpeg";
import parth from "../assets/parth.jpeg";
import vedant from "../assets/vedant.jpeg";
import viraj from "../assets/viraj.jpeg";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";

import Slider from "react-slick";
import "aos/dist/aos.css";
import AOS from "aos";
AOS.init();

export default class TeamSlider extends Component {
  constructor(props) {
    super(props);
    this.state = {
      nav1: null,
      nav2: null,
    };
  }

  componentDidMount() {
    this.setState({
      nav1: this.slider1,
      nav2: this.slider2,
    });
  }

  render() {
    return (
      <div>
        <Slider
          asNavFor={this.state.nav2}
          ref={(slider) => (this.slider1 = slider)}
        >
          <div className="bhurva">
            <div className="bhurva1">
              <img
                src={bhurva}
                className="photu"
                data-aos="fade-right"
                data-aos-duration="1200"
              />
              <div className="bhurva2">
                <h1
                  className="kartikey"
                  data-aos="fade-down"
                  data-aos-duration="1200"
                >
                  Bhurva sharma
                </h1>
                <p
                  className="parth"
                  data-aos="fade-up"
                  data-aos-duration="1200"
                >
                  UI/UX, App Developer
                </p>
                <p
                  className="parth"
                  data-aos="fade-up"
                  data-aos-duration="1200"
                >
                  App developer and UI/UX with a knack for overall perfection.
                </p>
              </div>
            </div>
          </div>
          <div className="bhurva">
            <div className="bhurva1">
              <img src={kartikey} className="photu" />
              <div className="bhurva2">
                <h1 className="kartikey">Kartikey Mahawar</h1>
                <p className="parth">App Developer</p>
                <p className="parth">
                  App developer with a solution for anything and everything.
                </p>
              </div>
            </div>
          </div>
          <div className="bhurva">
            <div className="bhurva1">
              <img src={parth} className="photu" />
              <div className="bhurva2">
                <h1 className="kartikey">Parth Katiyar</h1>
                <p className="parth">AI/Ml Developer</p>
                <p className="parth">Quick witted, extra calm ML - wiz.</p>
              </div>
            </div>
          </div>
          <div className="bhurva">
            <div className="bhurva1">
              <img src={vedant} className="photu" />
              <div className="bhurva2">
                <h1 className="kartikey">Vedant Singh</h1>
                <p className="parth">UI/UX,Frontend Web Developer</p>
                <p className="parth">
                  Sleep deprived web developer and design guy who can bring any
                  idea to life.
                </p>
              </div>
            </div>
          </div>
          <div className="bhurva">
            <div className="bhurva1">
              <img src={viraj} className="photu" />
              <div className="bhurva2">
                <h1 className="kartikey">Viraj Agarwal</h1>
                <p className="parth">Backend Web Developer</p>
                <p className="parth">
                  Very optimistic backend guy who always agrees to everything.
                </p>
              </div>
            </div>
          </div>
        </Slider>
        <div className="mari">
          <Slider
            asNavFor={this.state.nav1}
            ref={(slider) => (this.slider2 = slider)}
            slidesToShow={5}
            swipeToSlide={true}
            centerMode={true}
            focusOnSelect={true}
            autoplay={true}
            autoplaySpeed={2000}
            centerPadding={"5px"}
          >
            <div>
              <img src={bhurva} className="photu2" />
            </div>
            <div>
              <img src={kartikey} className="photu2" />
            </div>
            <div>
              <img src={parth} className="photu2" />
            </div>
            <div>
              <img src={vedant} className="photu2" />
            </div>
            <div>
              <img src={viraj} className="photu2" />
            </div>
          </Slider>
        </div>
      </div>
    );
  }
}
