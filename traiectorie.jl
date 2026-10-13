using Plots

const v0=10 #Initial Speed in m/s
const g=9.8 #Gravitational Acceleration in m/s^2

function ran(x) #Range
    angle=x

    range=((v0^2)*sin(2*angle))/g
    return range
end

function hmax(x) #Height
    angle=x
    h=((v0^2)*(sin(angle))^2)/(2*g)
    return h
end

function tof(x) #Flight Time (= Time Of Flight) in s
    angle=x
    t=(2*v0*sin(angle))/g
    return t
end

function an(x) #TOTAL=Range*Height*Flight_Time/10 in (m^2)/s
    an=tof(x)*hmax(x)*ran(x)/10
    return an
end

function main()

    x_vals = range(0, pi/2, length=1000)

    max_ran, idx_ran   = findmax(ran.(x_vals))
    max_hmax, idx_hmax = findmax(hmax.(x_vals))
    max_an, idx_an     = findmax(an.(x_vals))
    max_tof, idx_tof   = findmax(tof.(x_vals))

    println("Max Range:             ", round(max_ran, digits=3), " m     la ", round(x_vals[idx_ran]*180/pi, digits=1), "°")
    println("Max Height:            ", round(max_hmax, digits=3), "  m     la ", round(x_vals[idx_hmax]*180/pi, digits=1), "°")
    println("Max Flight Time:       ", round(max_tof, digits=3), "  s     la ", round(x_vals[idx_tof]*180/pi, digits=1), "°")
    println("Max TOTAL:             ", round(max_an, digits=3), "        la ", round(x_vals[idx_an]*180/pi, digits=1), "°")


    plot(ran,0,pi/2,xticks = ([0,pi/6,pi/4,pi/3,pi/2], ["0°","30°","45°","60°","90°"]),linecolor= :red, label="Range", ylabel="Meters", legend=:topleft)

    plot!(hmax,0,pi/2, linecolor= :blue, label="Max Height")

    plot!(an,0,pi/2, linecolor= :black, label="TOTAL")

    axa2=twinx()

    plot!(axa2, tof, 0, pi/2, 
        linecolor = :green, 
        label = "Flight Time",
        ylabel = "Time (s)",
        legend = (0.122, 0.775)
        )

end
main()

