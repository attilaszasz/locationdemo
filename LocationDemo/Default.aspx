<%@ Page Title="Geolocation" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="LocationDemo._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>Geolocation</h1>
        <p class="lead">A showcase of different methods to locate a user.</p>
    </div>

    <div class="row">
        <div class="col-md-4">
            <h2>Html5 Geolocation</h2>
            <p>
                The HTML5 Geolocation API is used to get the geographical position of a user.
                Since this can compromise user privacy, the position is not available unless the user approves it.
            </p>
            <p>
                <a class="btn btn-default" href="html5.html">See it in action &raquo;</a>
            </p>
        </div>
        <div class="col-md-4">
            <h2>freegeoip.net</h2>
            <p>
                Public RESTful web service API for searching geolocation of IP addresses.
                Uses MaxMind free database. Most sites that offer free or cheap geolocation services are based on the same database.
            </p>
            <p>
                <a class="btn btn-default" href="geoip.html">See it in action &raquo;</a>
            </p>
        </div>
        <div class="col-md-4">
            <h2>Self hosted service</h2>
            <p>
                Hosting the MaxMind database and looking up location on our own server.
            </p>
            <p>
                <a class="btn btn-default" href="selfhosted.aspx">See it in action &raquo;</a>
            </p>
        </div>
    </div>

</asp:Content>
