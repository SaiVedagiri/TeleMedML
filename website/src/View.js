import React from 'react';
import './assets/bootstrap/css/bootstrap.min.css'
import './assets/fontAwesome.css'
import './assets/googleCss.css'

class View extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            fullList: []
        }
    }

    async componentDidMount(){
        let response = await fetch('https://telemedml.macrotechsolutions.us/history', {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            }
        })
            .catch(err => console.log(err))
        let json = await response.json();
        try {
            this.setState({ fullList: json.data });
        } catch (e) {
            console.log(e);
            this.state = {
                fullList: json.data
            }
        }
    }

    render() {
        return (
            <div>
                <div id="wrapper">
                    <nav className="navbar navbar-dark align-items-start sidebar sidebar-dark accordion bg-gradient-primary p-0">
                        <div className="container-fluid d-flex flex-column p-0">
                            <a className="navbar-brand d-flex justify-content-center align-items-center sidebar-brand m-0" href="#">
                                <div className="sidebar-brand-icon rotate-n-15"><i className="fas fa-laugh-wink" /></div>
                                <div className="sidebar-brand-text mx-3"><span>Telemedml</span></div>
                            </a>
                            <hr className="sidebar-divider my-0" />
                            <ul className="nav navbar-nav text-light" id="accordionSidebar">
                                <li className="nav-item" role="presentation"><a className="nav-link active" href="/index.html"><i className="fas fa-tachometer-alt" /><span>Dashboard</span></a></li>
                                <li className="nav-item" role="presentation"><a className="nav-link" href="/login.html"><i className="far fa-user-circle" /><span>Login</span></a></li>
                                <li className="nav-item" role="presentation"><a className="nav-link" href="/register.html"><i className="fas fa-user-circle" /><span>Register</span></a></li>
                            </ul>
                            <div className="text-center d-none d-md-inline" />
                        </div>
                    </nav>
                    <div className="d-flex flex-column" id="content-wrapper">
                        <div id="content">
                            <nav className="navbar navbar-light navbar-expand bg-white shadow mb-4 topbar static-top">
                                <div className="container-fluid"><button className="btn btn-link d-md-none rounded-circle mr-3" id="sidebarToggleTop" type="button"><i className="fas fa-bars" /></button>
                                    <form className="form-inline d-none d-sm-inline-block mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
                                        <div className="input-group">
                                            <div className="input-group-append" />
                                        </div>
                                    </form>
                                    <ul className="nav navbar-nav flex-nowrap ml-auto">
                                        <li className="nav-item dropdown d-sm-none no-arrow"><a className="dropdown-toggle nav-link" data-toggle="dropdown" aria-expanded="false" href="#"><i className="fas fa-search" /></a>
                                            <div className="dropdown-menu dropdown-menu-right p-3 animated--grow-in" role="menu" aria-labelledby="searchDropdown">
                                                <form className="form-inline mr-auto navbar-search w-100">
                                                    <div className="input-group"><input className="bg-light form-control border-0 small" type="text" placeholder="Search for ..." />
                                                        <div className="input-group-append"><button className="btn btn-primary py-0" type="button"><i className="fas fa-search" /></button></div>
                                                    </div>
                                                </form>
                                            </div>
                                        </li>
                                        <li className="nav-item dropdown no-arrow mx-1" role="presentation">
                                            <div className="nav-item dropdown no-arrow"><a className="dropdown-toggle nav-link" data-toggle="dropdown" aria-expanded="false" href="#"><span className="badge badge-danger badge-counter" /></a>
                                                <div className="dropdown-menu dropdown-menu-right dropdown-list dropdown-menu-right animated--grow-in" role="menu">
                                                    <h6 className="dropdown-header">alerts center</h6>
                                                    <a className="d-flex align-items-center dropdown-item" href="#">
                                                        <div className="mr-3">
                                                            <div className="bg-primary icon-circle"><i className="fas fa-file-alt text-white" /></div>
                                                        </div>
                                                        <div><span className="small text-gray-500">December 12, 2019</span>
                                                            <p>A new monthly report is ready to download!</p>
                                                        </div>
                                                    </a>
                                                    <a className="d-flex align-items-center dropdown-item" href="#">
                                                        <div className="mr-3">
                                                            <div className="bg-success icon-circle"><i className="fas fa-donate text-white" /></div>
                                                        </div>
                                                        <div><span className="small text-gray-500">December 7, 2019</span>
                                                            <p>$290.29 has been deposited into your account!</p>
                                                        </div>
                                                    </a>
                                                    <a className="d-flex align-items-center dropdown-item" href="#">
                                                        <div className="mr-3">
                                                            <div className="bg-warning icon-circle"><i className="fas fa-exclamation-triangle text-white" /></div>
                                                        </div>
                                                        <div><span className="small text-gray-500">December 2, 2019</span>
                                                            <p>Spending Alert: We've noticed unusually high spending for your account.</p>
                                                        </div>
                                                    </a><a className="text-center dropdown-item small text-gray-500" href="#">Show All Alerts</a></div>
                                            </div>
                                        </li>
                                        <li className="nav-item dropdown no-arrow mx-1" role="presentation">
                                            <div className="nav-item dropdown no-arrow"><a className="dropdown-toggle nav-link" data-toggle="dropdown" aria-expanded="false" href="#" />
                                                <div className="dropdown-menu dropdown-menu-right dropdown-list dropdown-menu-right animated--grow-in" role="menu">
                                                    <h6 className="dropdown-header">alerts center</h6>
                                                    <a className="d-flex align-items-center dropdown-item" href="#">
                                                        <div className="dropdown-list-image mr-3"><img className="rounded-circle" src="/assets/img/avatars/avatar4.jpeg?h=fefb30b61c8459a66bd338b7d790c3d5" />
                                                            <div className="bg-success status-indicator" />
                                                        </div>
                                                        <div className="font-weight-bold">
                                                            <div className="text-truncate"><span>Hi there! I am wondering if you can help me with a problem I've been having.</span></div>
                                                            <p className="small text-gray-500 mb-0">Emily Fowler - 58m</p>
                                                        </div>
                                                    </a>
                                                    <a className="d-flex align-items-center dropdown-item" href="#">
                                                        <div className="dropdown-list-image mr-3"><img className="rounded-circle" src="/assets/img/avatars/avatar2.jpeg?h=5d142be9441885f0935b84cf739d4112" />
                                                            <div className="status-indicator" />
                                                        </div>
                                                        <div className="font-weight-bold">
                                                            <div className="text-truncate"><span>I have the photos that you ordered last month!</span></div>
                                                            <p className="small text-gray-500 mb-0">Jae Chun - 1d</p>
                                                        </div>
                                                    </a>
                                                    <a className="d-flex align-items-center dropdown-item" href="#">
                                                        <div className="dropdown-list-image mr-3"><img className="rounded-circle" src="/assets/img/avatars/avatar3.jpeg?h=c5166867f10a4e454b5b2ae8d63268b3" />
                                                            <div className="bg-warning status-indicator" />
                                                        </div>
                                                        <div className="font-weight-bold">
                                                            <div className="text-truncate"><span>Last month's report looks great, I am very happy with the progress so far, keep up the good work!</span></div>
                                                            <p className="small text-gray-500 mb-0">Morgan Alvarez - 2d</p>
                                                        </div>
                                                    </a>
                                                    <a className="d-flex align-items-center dropdown-item" href="#">
                                                        <div className="dropdown-list-image mr-3"><img className="rounded-circle" src="/assets/img/avatars/avatar5.jpeg?h=35dc45edbcda6b3fc752dab2b0f082ea" />
                                                            <div className="bg-success status-indicator" />
                                                        </div>
                                                        <div className="font-weight-bold">
                                                            <div className="text-truncate"><span>Am I a good boy? The reason I ask is because someone told me that people say this to all dogs, even if they aren't good...</span></div>
                                                            <p className="small text-gray-500 mb-0">Chicken the Dog · 2w</p>
                                                        </div>
                                                    </a><a className="text-center dropdown-item small text-gray-500" href="#">Show All Alerts</a></div>
                                            </div>
                                            <div className="shadow dropdown-list dropdown-menu dropdown-menu-right" aria-labelledby="alertsDropdown" />
                                        </li>
                                        <div className="d-none d-sm-block topbar-divider" />
                                        <li className="nav-item dropdown no-arrow" role="presentation">
                                            <div className="nav-item dropdown no-arrow"><a className="dropdown-toggle nav-link" data-toggle="dropdown" aria-expanded="false" href="#"><span className="d-none d-lg-inline mr-2 text-gray-600 small">Valerie Luna</span></a>
                                                <div className="dropdown-menu shadow dropdown-menu-right animated--grow-in" role="menu"><a className="dropdown-item" role="presentation" href="#"><i className="fas fa-user fa-sm fa-fw mr-2 text-gray-400" />&nbsp;Profile</a><a className="dropdown-item" role="presentation" href="#"><i className="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400" />&nbsp;Settings</a>
                                                    <a className="dropdown-item" role="presentation" href="#"><i className="fas fa-list fa-sm fa-fw mr-2 text-gray-400" />&nbsp;Activity log</a>
                                                    <div className="dropdown-divider" /><a className="dropdown-item" role="presentation" href="#"><i className="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400" />&nbsp;Logout</a></div>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </nav>
                            <div className="container-fluid">
                                <div className="d-sm-flex justify-content-between align-items-center mb-4">
                                    <h3 className="text-dark mb-0">Dashboard</h3>
                                </div>
                            </div>
                            <div className="col-auto col-lg-12 col-xl-12 text-left align-self-stretch m-auto justify-content-lg-center justify-content-xl-center">
                                <div className="card shadow mb-4">
                                    <div className="card-header d-flex justify-content-between align-items-center">
                                        <h6 className="text-primary font-weight-bold m-0">History</h6>
                                    </div>
                                </div>
                                <div className="table-responsive">
                                    <table className="table">
                                        <thead>
                                            <tr>
                                                <th>Author</th>
                                                <th>Temperature</th>
                                                <th>Congestion</th>
                                                <th>Cough</th>
                                                <th>Headache</th>
                                                <th>Sneeze</th>
                                                <th>Symptoms</th>
                                                <th>Confidence</th>
                                                <th>COVID-19</th>
                                                <th>Diagnosis</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            {this.state.fullList.map(
                                                function (data, index) {
                                                    return (<tr key={index}>
                                                        <td>{data.Author}</td>
                                                        <td>{data.Temperature}</td>
                                                        <td>{data.Congestion}</td>
                                                        <td>{data.Cough}</td>
                                                        <td>{data.Headache}</td>
                                                        <td>{data.Sneeze}</td>
                                                        <td>{data.Symptoms}</td>
                                                        <td>{data.confidence}</td>
                                                        <td>{data.covid}</td>
                                                        <td>{data.diagnosis}</td>
                                                    </tr>)
                                                })
                                            }
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <footer className="bg-white sticky-footer">
                            <div className="container my-auto">
                                <div className="text-center my-auto copyright"><span>Copyright © TeleMedML 2020</span></div>
                            </div>
                        </footer>
                    </div>
                </div>
            </div>
        );
    }

}

export default View