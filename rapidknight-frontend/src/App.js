import "./App.css";
import SignIn from "./pages/SignIn";
import Register from "./pages/Register";
import Home from "./pages/Home";
import MarketPlace from "./pages/MarketPlace";
import Basket from "./pages/Basket";

import { BrowserRouter as Router, Switch, Route } from "react-router-dom";
import DriverDetails from "./pages/DriverDetails";

function App() {
  return (
    <>
      <Router>
        <Switch>
          <Route path="/" exact>
            <SignIn />
          </Route>
          <Route path="/register" exact>
            <Register />
          </Route>
          <Route path="/home" exact>
            <Home />
          </Route>

          <Route path="/basket/:id/:title" strict exact>
            <Basket />
          </Route>
          <Route path="/marketplace" strict exact>
            <MarketPlace />
          </Route>
          <Route path="/OrderDetails" strict exact>
            <DriverDetails />
          </Route>
        </Switch>
      </Router>
    </>
  );
}

export default App;
