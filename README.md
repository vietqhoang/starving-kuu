When I started at [Tofugu](https://www.tofugu.com) one of my first tasks was to learn how to work with modern (at that time) web frameworks. Ruby on Rails was the hotness at the time, so I set out to learn Ruby.

One of my first applications of Ruby was a random restaurant selector. At Tofugu we go out to lunch every work day. After a while it was hard for the three of us (at that time) to commit to choosing a restaurant. Solving the issue was what spawned the project. I called it _Hungry Kuu_.

The restaurant selector got a lot of use at the time, but has since been abandoned.

Flash forward to today we have one individual who started learning programming. And being one of the few developers in our company it is my job to mentor them. We were brain-storming small project ideas and the random restaurant selector came up. We still do lunches at Tofugu, so we thought it'll be a good application for them to build.

While this individual sets out to solve the problem I am behind-the-scenes recreating the application with my current knowledge. The purpose of doing this is to eventually share the project with the individual (and possibly future interested employees) on how I managed the work, the design choices made, and comparing coding styles. And what over-engineering looks like (haha). This project honestly didn't need to go beyond the first couple user stories.

## Who is Kuu

Kuu was Koichi's cat. When I started at Tofugu we were working out of his apartment and Kuu was always around begging for food.

We did a proof-of-concept where we wrote each restaurant's name on index cards and placed a treat on each one. We set the cat loose and whatever treat she went for was the restaurant we were going to have lunch at.

Funny enough she chose the card that was furthest from her. And the response time was horrible. I would have liked to benchmark it 10_000 times, but I don't think Koichi would have liked ending up with a fat cat.

# Installation

1.  Clone project
2.  `bundle install`
3.  Create `_data/restaurants.yml` and add your list of restaurants in the Array format
4.  `ruby lib/starving_kuu.rb prompt`
