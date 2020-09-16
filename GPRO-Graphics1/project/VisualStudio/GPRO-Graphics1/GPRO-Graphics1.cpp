/*
   Copyright 2020 Daniel S. Buckstein

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

	   http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

/*
Author: Mitko
Class: GPR-200-01/02/03: Introduction to Modern Graphics Programming
Assignment: Lab 1
Date Assigned: 09/04/2020
Due Date: 09/11/2020
Description: With a given dataset, generate two pieces of information that are not within the dataset
Certification of Authenticity:
I certify that this is entirely my own work, except where I have given
fully-documented references to the work of others. I understand the
definition and consequences of plagiarism and acknowledge that the assessor
of this assignment may, for the purpose of assessing this assignment:
- Reproduce this assignment and provide a copy to another member of
academic staff; and/or
- Communicate a copy of this assignment to a plagiarism checking
service (which may then retain a copy of this assignment on its
database for the purpose of future plagiarism checking)
*/

/*
	GPRO-Graphics1.c/.cpp
	Main source file for GPRO-Graphics1 library.

	Modified by: Mitko Ivanov
	Modified because: Intro to Graphics - Lab 1

    Using influence from "Ray Tracing in One Weekend" by Peter Shirley
    https://raytracing.github.io/books/RayTracingInOneWeekend.html#overview
*/

#include <iostream>

using namespace std;
#include "vec3.h"
#include "color.h"
#include "ray.h"

bool hit_sphere(const point3& center, double radius, const ray& r) {
    vec3 oc = r.origin() - center;
    double a = dot(r.direction(), r.direction());
    double b = 2.0 * dot(oc, r.direction());
    double c = dot(oc, oc) - radius * radius;
    double discriminant = (b * b) - (4.0 * a * c);
    return (discriminant > 0);
}

//Using influence from "Ray Tracing in One Weekend" by Peter Shirley
//https ://raytracing.github.io/books/RayTracingInOneWeekend.html#overview

color ray_color(const ray& r) {
    if (hit_sphere(point3(0, 0, -1), 0.5, r))
        return color(1, 0, 0);
    vec3 unit_direction = unit_vector(r.direction());
    double t = 0.5 * (unit_direction.y() + 1.0);
    return (1.0 - t) * color(1.0, 1.0, 1.0) + t * color(0.5, 0.7, 1.0);
}

//Using influence from "Ray Tracing in One Weekend" by Peter Shirley
//https ://raytracing.github.io/books/RayTracingInOneWeekend.html#overview


int main() {
    // Image

    const double aspect_ratio = 16.0 / 9.0;
    const int image_width = 50;
    const int image_height = static_cast<int>(image_width / aspect_ratio);

    //Using influence from "Ray Tracing in One Weekend" by Peter Shirley
    //https ://raytracing.github.io/books/RayTracingInOneWeekend.html#overview

    // Camera

    double viewport_height = 2.0;
    double viewport_width = aspect_ratio * viewport_height;
    double focal_length = 1.0;

    vec3 origin = point3(0, 0, 0);
    vec3 horizontal = vec3(viewport_width, 0, 0);
    vec3 vertical = vec3(0, viewport_height, 0);
    vec3 lower_left_corner = origin - horizontal / 2 - vertical / 2 - vec3(0, 0, focal_length);

    //Using influence from "Ray Tracing in One Weekend" by Peter Shirley
    //https ://raytracing.github.io/books/RayTracingInOneWeekend.html#overview

    // Render

    cout << "P3\n" << image_width << ' ' << image_height << "\n255\n";

    for (int j = image_height - 1; j >= 0; --j) {
        for (int i = 0; i < image_width; ++i) {
            cerr << "\rScanlines remaining: " << j << " " << flush;
            /*double r = double(i) / (image_width - 1.0);
            double g = double(j) / (image_height - 1.0);
            double b = 0.25;

            int ir = static_cast<int>(255.999 * r);
            int ig = static_cast<int>(255.999 * g);
            int ib = static_cast<int>(255.999 * b);

            cout << ir << ' ' << ig << ' ' << ib << '\n';*/

            for (int i = 0; i < image_width; ++i) {
                double u = double(i) / (image_width - 1);
                double v = double(j) / (image_height - 1);
                ray r(origin, lower_left_corner + u * horizontal + v * vertical - origin);
                color pixel_color = ray_color(r);

                //color pixel_color(double(i) / (image_width - 1.0), double(j) / (image_height - 1), 0.25);
                write_color(cout, pixel_color);
            }
        }
    }

    cerr << "\nDone. \n";

    //Using influence from "Ray Tracing in One Weekend" by Peter Shirley
    //https ://raytracing.github.io/books/RayTracingInOneWeekend.html#overview

}