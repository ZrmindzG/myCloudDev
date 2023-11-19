@RestController
public class flights {
    @GetMapping("/flights")
    public String getData(){
        return
                "Please book your hotel at 70% off";
    }
}