open Lwt
open Cohttp_lwt_unix
let server =
  ((let callback _conn _req body =
      ((body |> Cohttp_lwt.Body.to_string) >|=
         (fun body ->
            Printf.sprintf (("Hello! %s")[@reason.raw_literal "Hello! %s"])
              body))
        >>= (fun body -> Server.respond_string ~status:`OK ~body ()) in
    Server.create ~mode:(`TCP (`Port 8000)) (Server.make ~callback ()))
  [@reason.preserve_braces ])
let () = Lwt_main.run server
