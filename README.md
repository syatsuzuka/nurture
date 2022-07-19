# 👨‍👧‍👦NURTURE 
<i> The easiest way to help tutors engage with students and guide their progress. </i>

## Background
Nurture was an idea that developed from a real life tennis tutor friend that was having difficulty in maintaining records for his students, especially because all their feedback was written on paper forms. He really needed a way to properly maintain all feedback, visually see the data on his students lesson improvement over time, and communicate with his students one-on-one. The Nurture team then set about to create a platform with a primary focus for helping tennis tutors teach their students more effectively by seeing their progress on a chart and allocating more homework in the areas they were struggling.

App home: https://nurture-lw.herokuapp.com/

<img src="https://res.cloudinary.com/snoared/image/upload/v1655352583/screenshot-nurture-lw.herokuapp.com-2022.06.16-11_57_36_udracf.png" width="850" height="420">
<img src="https://res.cloudinary.com/snoared/image/upload/v1655352583/screenshot-nurture-lw.herokuapp.com-2022.06.16-11_58_04_fa7nak.png" width="850" height="600">
<img src="https://res.cloudinary.com/snoared/image/upload/v1655352583/screenshot-nurture-lw.herokuapp.com-2022.06.16-11_58_49_ucho4w.png" width="850" height="420">

## Getting Started
### Setup

Install gems
```
bundle install
```
Install JS packages
```
yarn install
```

### ENV Variables
Create `.env` file
```
touch .env
```
Inside `.env`, set these variables. For any APIs, see group Slack channel.
```
CLOUDINARY_URL=your_own_cloudinary_url_key
```

### DB Setup
```
rails db:create
rails db:migrate
rails db:seed
```

### Run a server
```
rails s
```

## Built With
- [Rails 6](https://guides.rubyonrails.org/) - Backend / Front-end
- [Stimulus JS](https://stimulus.hotwired.dev/) - Front-end JS
- [Heroku](https://heroku.com/) - Deployment
- [PostgreSQL](https://www.postgresql.org/) - Database
- [Bootstrap](https://getbootstrap.com/) — Styling
- [Figma](https://www.figma.com) — Prototyping

## Roles and Acknowledgements
* Shunjiro - lead developer
* James - lead back-end 
* Shingo - lead front-end
* Ed - Project Manager

## Team Members
- [Shunjiro Yatsuzuka](https://www.linkedin.com/in/syatsuzuka/)
- [James reed](https://github.com/Jimreed91)
- [Shingo Kubomura](https://www.linkedin.com/in/shingokubomura/)
- [Edmund Oh](https://www.linkedin.com/in/edmund-0h/)

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
This project is licensed under the MIT License
