//
//  SignupViewController.swift
//  project2
//
//  Created by COE-02 on 21/01/20.
//  Copyright © 2020 COE-02. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController,UIPickerViewDelegate,
    UIPickerViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    var db = dbmanager()
    var imgPicker = UIImagePickerController()
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var City: UITextField!
    @IBOutlet weak var emailid: UITextField!
     var arrGender = ["Male","Female","Other"]
    
    
    @IBAction func signup(_ sender: UIButton)
    {
        let Gender = arrGender[segment.selectedSegmentIndex]
        
        let UserImage = UIImageJPEGRepresentation(img.image!,1.0)
        
        
        let command = "INSERT INTO Userinfo (Username,Password,Gender,Emailid,Userimage,City) VALUES('\(Username.text!)','\(Password.text!)','\(Gender)','\(emailid.text!)','\(UserImage!)','\(City.text!)')"
        if db.RunCommand(cmd: command)
        {
            print("Data Saved!")
            
            let alert = UIAlertController(title: "Sign Up", message: "Your data in saved Succefully", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                self.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            print("Not Saved!")
        }
        
    }
    // code for pickerview which has city name
    var cities = ["Ahmedabad","Amreli district","Anand","Banaskantha","Bharuch","Bhavnagar","Dahod","The Dangs","Gandhinagar","Jamnagar","Junagadh","Kutch","Kheda","Mehsana","Narmada","Navsari","Patan","Panchmahal","Porbandar","Rajkot","Sabarkantha","Surendranagar","Surat","Vyara","Vadodara","Valsad"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return cities.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return cities[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        City.text = cities[row]
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func inputimage(_ sender: UIButton)
    {
        imgPicker = UIImagePickerController()
        imgPicker.sourceType = .photoLibrary
        
        
        imgPicker.delegate = self
        
        //self.navigationController?.pushViewController(imgPicker, animated: true)
        self.present(imgPicker, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imag = info[UIImagePickerControllerOriginalImage] as! UIImage
        img.image = imag
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        //self.navigationController?.popViewController(animated: true)//.pop(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }

   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
